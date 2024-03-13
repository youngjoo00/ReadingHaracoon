//
//  TabBarController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstTab = UINavigationController(rootViewController: StorageBookViewController())
        let firstTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = UINavigationController(rootViewController: SearchViewController())
        let secondTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        secondTab.tabBarItem = secondTabBarItem
        
        let thirdTab = UINavigationController(rootViewController: StatsViewController())
        let thirdTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "chart.bar"), tag: 2)
        thirdTab.tabBarItem = thirdTabBarItem
        
        let forthTab = UINavigationController(rootViewController: SettingViewController())
        let forthTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape"), tag: 3)
        forthTab.tabBarItem = forthTabBarItem
        
        self.viewControllers = [firstTab, secondTab, thirdTab, forthTab]
    }

}
