//
//  CatViewController.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 02/06/22.
//

import UIKit

class CategoryViewController: UIViewController{

    var cellId = "Cell"
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var titles = [CategoryData]()
    var filteredData=[CategoryData]()
    
    private let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatInfo()
        filteredData = titles
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 170, height: 200)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
        
        
        navigationItem.searchController = search
        search.searchBar.delegate=self
        navigationController?.navigationBar.prefersLargeTitles=true
        self.title = "Categories"
        
        view.backgroundColor = .secondarySystemBackground
        
    }
}
// MARK:  - COLLECTIONVIEW
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! MyCollectionViewCell
        cell.titleLabel.text = filteredData[indexPath.row].title
        cell.image.image = filteredData[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = NewsViewController()
        controller.newsURL = "category="+filteredData[indexPath.row].title
        controller.title = filteredData[indexPath.row].title
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK:  - DATA
extension CategoryViewController{
    func creatInfo(){
        titles = [
            CategoryData(title: "Sports", image: UIImage(named: "sports")!),
            CategoryData(title: "General", image: UIImage(named: "general")!),
            CategoryData(title: "Health", image: UIImage(named: "health")!),
            CategoryData(title: "Science", image: UIImage(named: "science")!),
            CategoryData(title: "Business", image: UIImage(named: "business")!),
            CategoryData(title: "Technology", image: UIImage(named: "technology")!),
            CategoryData(title: "Entertainment", image: UIImage(named: "entertainment")!),
        ]
    }
}


// MARK:  - SEARCH
extension CategoryViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
            return
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? titles : titles.filter({ (obj:CategoryData) -> Bool in
            return obj.title.range(of: searchText, options: .caseInsensitive) != nil
        })
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData=titles
        self.collectionView.reloadData()
    }
}
