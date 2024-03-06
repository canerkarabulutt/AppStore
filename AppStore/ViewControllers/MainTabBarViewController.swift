//
//  MainTabBarViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = AppsViewController()
        let vc2 = SearchViewController()
        let vc3 = SettingsViewController()
        
        vc1.title = "Apps"
        vc2.title = "Search"
        vc3.title = "Settings"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc1.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: "Apps", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "globe"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
        tabBarConfiguration()
    }
    private func tabBarConfiguration() {

        self.tabBar.itemPositioning = .fill
        self.tabBar.backgroundColor = .secondarySystemGroupedBackground
        self.tabBar.tintColor = .darkGray
        self.tabBar.unselectedItemTintColor = .lightGray
    }
}
