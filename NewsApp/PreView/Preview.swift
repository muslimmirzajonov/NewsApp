//
//  Preview.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 02/06/22.
//

import Foundation
import UIKit
class PreViewViewController: UIViewController {
    
    let tableView = UITableView()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 12)
        textView.translatesAutoresizingMaskIntoConstraints=false
        textView.text = ""
        return textView
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    @MainLabel(text: "", size: 16, weight: UIFont.Weight.bold, color: UIColor.black)
    var notTitle: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
//        navigationController?.navigationBar.prefersLargeTitles=true
        self.title = "Preview"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate=self
        tableView.dataSource=self
        tableView.reloadData()
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        tableView.showsVerticalScrollIndicator=false
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = view.bounds
    }
}

extension PreViewViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "TrailerMapCell"
        tableView.register(PreViewCell.self, forCellReuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PreViewCell
        tableView.layer.cornerRadius=15
        cell.isUserInteractionEnabled = true
        cell.title.text = notTitle.text
        cell.textView.text = textView.text
        cell.activityIndicator.startAnimating()
        cell.title.isHidden=true
        DispatchQueue.main.async {
            cell.image.image = self.image.image
            cell.activityIndicator.stopAnimating()
            cell.title.isHidden=false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
