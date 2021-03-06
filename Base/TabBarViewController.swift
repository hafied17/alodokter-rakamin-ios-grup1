//
//  TabBarViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    let profileView = UIView()
    let userDefaults = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "blue something")
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBarSetup()
    }
    
    func tabBarSetup() {
        if userDefaults.value(forKey: "token") == nil {
            viewControllers = [
            createTabBatItem(for: ArticleListViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(named: "HomeIcon")!)
            ]
        } else {
            viewControllers = [
            createTabBatItem(for: ArticleListViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(named: "HomeIcon")!),
            createTabBatItem(for: ConsulViewController(), title: NSLocalizedString("Consultation", comment: ""), image: UIImage(named: "DoctorIcon")!),
            createTabBatItem(for: HistoryViewController(), title: NSLocalizedString("History", comment: ""), image: UIImage(named: "HistoryIcon")!)
            ]
        }
    }
    
    fileprivate func createTabBatItem(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return nav
    }
}
