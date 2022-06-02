//
//  TabControllerViewController.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import UIKit

class TabController: UITabBarController {

    @MainLabel(text: "Turn on cellucar data or use \nWI-FI to access the \nMNews", size: 24, weight: UIFont.Weight.regular, color: UIColor.systemGray)
    var lanLabel: UILabel
    
    var lanView = MNewsAppView()
    var lanBtn = MNewsAppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarControllers()
#if targetEnvironment(simulator)
        forConntected()
#else
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: nil)
        updateUserInterface()
        setupUi()
#endif
    }
    
    
    func setTabBarControllers() {
        self.setViewControllers([YouViewController(), SearchViewController(), CategoryViewController()].map{
            UINavigationController(rootViewController: $0)
        }, animated: true)
        tabBar.backgroundColor = UIColor.secondarySystemBackground
        tabBar.items?[0].image=UIImage(systemName: "newspaper")
        tabBar.items?[0].title="NEWS"
        tabBar.items?[1].image=UIImage(systemName: "magnifyingglass")
        tabBar.items?[1].title="SEARCH"
        tabBar.items?[2].image=UIImage(systemName: "square.fill.text.grid.1x2")
        tabBar.items?[2].title="CATEGORY"
    }

}
//MARK: - Reachability
extension TabController{
    @objc func openCellular(){
        if let url = URL(string:"App-Prefs:root=WIFI") {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            self.view.backgroundColor = .white
            UIApplication.shared.statusBarStyle = .darkContent
            self.lanView.isHidden=false
        case .wwan:
            self.forConntected()
        case .wifi:
            self.forConntected()
        }
    }
    
    func forConntected(){
        self.tabBarController?.tabBar.isHidden = false
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        self.lanView.isHidden=true
    }
    
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    func setupUi(){
        view.addSubview(lanView)
        lanView.backgroundColor = .white
        lanView.leftOfLeft(view: view, const: 0)
        lanView.rightOfRight(view: view, const: 0)
        lanView.topOfTop(view: view, const: 0)
        lanView.bottomOfBottom(view: view, const: 0)
        
        lanView.addSubview(lanLabel)
        lanLabel.numberOfLines=3
        lanLabel.leftOfLeft(view: lanView, const: 10)
        lanLabel.rightOfRight(view: lanView, const: -10)
        lanLabel.centerY(view: lanView, const: -30)
        
        lanView.addSubview(lanBtn)
        lanBtn.layer.cornerRadius=4
        lanBtn.layer.borderColor = UIColor.systemGray.cgColor
        lanBtn.layer.borderWidth=1
        lanBtn.setTitle("Settings", for: .normal)
        lanBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        lanBtn.setTitleColor(UIColor.systemGray, for: .normal)
        lanBtn.addTarget(self, action: #selector(openCellular), for: .touchUpInside)
        lanBtn.height(const: 30)
        lanBtn.width(const: 100)
        lanBtn.topOfBottom(view: lanLabel, const: 10)
        lanBtn.centerX(view: lanView, const: 0)
    }
}
