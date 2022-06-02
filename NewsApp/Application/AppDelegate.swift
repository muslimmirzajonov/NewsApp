//
//  AppDelegate.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        do {
             try Network.reachability = Reachability(hostname: "www.google.com")
         }
         catch {
             switch error as? Network.Error {
             case let .failedToCreateWith(hostname)?:
                 print("Network error:\nFailed to create reachability object With host named:", hostname)
             case let .failedToInitializeWith(address)?:
                 print("Network error:\nFailed to initialize reachability object With address:", address)
             case .failedToSetCallout?:
                 print("Network error:\nFailed to set callout")
             case .failedToSetDispatchQueue?:
                 print("Network error:\nFailed to set DispatchQueue")
             case .none:
                 print(error)
             }
         }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}
