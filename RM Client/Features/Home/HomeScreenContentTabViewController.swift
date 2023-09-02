//
//  HomeScreenContentTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class HomeScreenContentTabViewController: UITabBarController {
    
    public static func getInstance() -> HomeScreenContentTabViewController {
        return HomeScreenContentTabViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.tintColor = RmThemeUtils.shared.getApplicationPrimaryColor()
        
        setViewControllers([
            getTabViewController(vc: HomeTabViewController.getInstance(), image: "house", title: "home"),
            getTabViewController(vc: EpisodsTabViewController.getInstance(), image: "list.bullet", title: "episods"),
            getTabViewController(vc: LocationsTabViewController.getInstance(), image: "location", title: "locations"),
        ], animated: true)
    }

    private func getTabViewController(vc: UIViewController, image: String, title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.tabBarItem.image = UIImage(systemName: image)
        navigationController.title = title.getLocalizedString()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        
        
        
        return navigationController
    }

}
