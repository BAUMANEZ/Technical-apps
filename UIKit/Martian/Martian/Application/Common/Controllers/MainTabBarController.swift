//
//  MartianTabBarController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    typealias TabBarItemTuple = (viewController: UIViewController, title: String?, imageName: String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.unselectedItemTintColor = .unselected
        tabBar.tintColor = .selected
        tabBar.barTintColor = .white
        
        let camerasItem:  TabBarItemTuple = (CamerasTableViewController(), "Камеры", "quality")
        let settingsItem: TabBarItemTuple = (SettingsTableViewController(), "Настройки", "settings")
        
        viewControllers = [
            camerasItem,
            settingsItem
        ].map {
            createTabBarItem(with: $0)
        }
    }
}

//MARK: - Tab bar item container
extension MainTabBarController {
    func createTabBarItem(with itemDescription: TabBarItemTuple ) -> UINavigationController {
        let tabBarItem = UITabBarItem(title: itemDescription.title,
                                      image: UIImage(named: itemDescription.imageName),
                                      selectedImage: nil)
        tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.font : Body.small ?? UIFont.systemFont(ofSize: 12)],
            for: .normal)
        itemDescription.viewController.tabBarItem = tabBarItem
        
        return UINavigationController(rootViewController: itemDescription.viewController)
    }
    
}


