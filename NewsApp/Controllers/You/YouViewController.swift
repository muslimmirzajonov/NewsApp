//
//  YouViewController.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import UIKit
import SafariServices
class YouViewController: UIViewController{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints=false
        return activityIndicator
    }()
    
    
    private var articleListViewModel: ArticleListViewModel!
    public var newsURL: String = String()
    private var page = 0
    private var endAlertShown = false
    
    var refreshControlForTable:UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = UIColor.secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles=true
        let rightButton = UIBarButtonItem.init(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(reTryPress))

        self.navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate=self
        tableView.dataSource=self
        tableView.allowsMultipleSelection = true
        self.tableView.reloadData()
        view.addSubview(tableView)
        
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        
        loadData()
        self.page = 1
    }
    
    @objc func reTryPress(){
        refreshLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        title = "News"
    }
    
    
}

//MARK: - TABLEVIEW
extension YouViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = 100
        height = UITableView.automaticDimension
        return height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListViewModel == nil ? 0: self.articleListViewModel.noOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        let articleAtCell = self.articleListViewModel.articleAtIndex(indexPath.row)
        cell.newTitleLabel.text = articleAtCell.title
        cell.subTitleLabel.text = articleAtCell.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = PreViewViewController()
        let articleAtCell = self.articleListViewModel.articleAtIndex(indexPath.row)
        controller.notTitle.text = articleAtCell.title
        controller.textView.text = articleAtCell.description
        
        DispatchQueue.main.async {
            let url = NSURL(string: articleAtCell.urlToImage)
            let imagedata = NSData.init(contentsOf: url! as URL)
            guard let data = imagedata else { return }
            controller.image.image = UIImage(data: data as Data)
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createSpinerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x: -5, y: 0, width: view.frame.size.width, height: 40))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

//MARK: - SCROLLVIEW DELEGATE
extension YouViewController{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height && (page-1)*20 < self.articleListViewModel.totalNoOfArticles()){
            fetchAdditionalNewsArticles()
        }
        if (page-1)*20 > self.articleListViewModel.totalNoOfArticles() && !endAlertShown {
            endAlertShown = true
        }
    }
}

//MARK: - DYNAMICALLY APPEND NEW ITEMS
extension YouViewController {
    func fetchAdditionalNewsArticles() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = self.createSpinerFooter()
        }
        print("Fetching addtional news articles: \(self.page)")
        WebService().getArticles(for: "all", with: self.page) { articles, totalResults in
            if let newArticles = articles {
                self.page = self.page + 1
                let intialCount = self.articleListViewModel.numberOfRowsInSection(0)
                self.articleListViewModel.add(newArticles: newArticles)
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                    let finalCount = self.articleListViewModel.numberOfRowsInSection(0)
                    let indexPaths = (intialCount ..< finalCount).map {
                        IndexPath(row: $0, section: 0)
                    }
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: indexPaths, with: .automatic)
                    self.tableView.endUpdates()
                }
            } else {
                print("No data for page: \(self.page)")
            }
        }
    }
}

//MARK: BINDING
extension YouViewController{
    private func loadData() {
        var dataFetched = false
        activityIndicator.startAnimating()
        WebService().getArticles(for: "all", with: page) { articles, totalResults in
            if let articles = articles {
                dataFetched = true
                self.page = self.page + 1
                self.articleListViewModel = ArticleListViewModel(articles, totalArticles: totalResults)
            } else {
                print("No data")
                self.tableView.isHidden=true
                
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if dataFetched {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func refreshLoad(){
        activityIndicator.startAnimating()
        WebService().getArticles(for: "all", with: self.page) { articles, totalResults in
            if articles != nil {

                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
    }
}
}
