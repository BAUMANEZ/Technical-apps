//
//  MartianTabBarController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit
import Nuke

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
        let image = UIImage(named: itemDescription.imageName)
        let title = itemDescription.title
        let viewController = itemDescription.viewController
        let tabBarItem = UITabBarItem(title: title,
                                      image: image,
                                      selectedImage: nil)
        tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.font : Body.small ?? UIFont.systemFont(ofSize: 12)],
            for: .normal)
        viewController.tabBarItem = tabBarItem
        
        return UINavigationController(rootViewController: viewController)
    }
    
}

extension MainTabBarController: Networking {
    func didLoadDate() {
        if
            let navigationController = viewControllers?[0] as? UINavigationController,
            let camerasViewController = navigationController.viewControllers.first as? CamerasTableViewController
        {
            (camerasViewController.viewModel as? CamerasViewModel)?.loadDate()
        }
    }
    
    func didLoad(roverList: RoversList) {
        if
            let navigationController = viewControllers?[1] as? UINavigationController,
            let settingsViewController = navigationController.viewControllers.first as? SettingsTableViewController
        {
            (settingsViewController.viewModel as? SettingsViewModel)?.getRoversFrom(roverList)
        }
    }
}


