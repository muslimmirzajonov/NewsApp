//
//  SearchViewController.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import UIKit
import SafariServices
class SearchViewController: UIViewController, UISearchBarDelegate{

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
    private let search = UISearchController(searchResultsController: nil)
    
    private var page = 0
    private var endAlertShown = false
    var searchTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles=true
        self.title = "Search"
        navigationController?.navigationBar.barTintColor = UIColor.secondarySystemBackground
        
        tableView.delegate=self
        tableView.dataSource=self
        view.addSubview(tableView)
        
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        
        self.createSearch()
        self.page = 1
    }
    
    func createSearch(){
        navigationItem.searchController = search
        search.searchBar.delegate=self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

//MARK: - TABLEVIEW

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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

// MARK: - DYNAMICALLY APPEND NEW ITEM
extension SearchViewController {
    func fetchAdditionalNewsArticles() {
        print("Fetching addtional news articles: \(self.page)")
        WebService().getArticles(for: "q="+searchTitle, with: self.page) { articles, totalResults in
            if let newArticles = articles {
                self.page = self.page + 1
                let intialCount = self.articleListViewModel.numberOfRowsInSection(0)
                self.articleListViewModel.add(newArticles: newArticles)
                DispatchQueue.main.async {
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
                self.tableView.tableFooterView=nil
                
            }
        }
    }
}
//MARK: - SEARCH
extension SearchViewController{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTitle = searchBar.text!
        if searchTitle.isEmpty{
            return
        }
        var dataFetched = false
        print("Setting up view")
        self.tableView.tableFooterView=createSpinerFooter()
        print("Fetching Webservice articles")
        WebService().getArticles(for: "q="+searchTitle, with: page) { articles, totalResults in
            if let articles = articles {
                dataFetched = true
                self.page = self.page + 1
                self.articleListViewModel = ArticleListViewModel(articles, totalArticles: totalResults)
            } else {
                print("No data")
                self.tableView.isHidden=true
            }
            DispatchQueue.main.async {
                
                if dataFetched {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height && (page-1)*20 < self.articleListViewModel.totalNoOfArticles()){
            print("Requesting for new articles")
            fetchAdditionalNewsArticles()
        }else{

        }
        if (page-1)*20 > self.articleListViewModel.totalNoOfArticles() && !endAlertShown {
            endAlertShown = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
}
