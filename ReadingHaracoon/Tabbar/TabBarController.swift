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
        
        if let image = UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(weight: .medium)) {
            firstTabBarItem.image = image.imageWithoutBaseline()
        }
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = UINavigationController(rootViewController: SearchViewController())
        let secondTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        if let image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .medium)) {
            secondTabBarItem.image = image.imageWithoutBaseline()
        }
        secondTab.tabBarItem = secondTabBarItem
        
        let thirdTab = UINavigationController(rootViewController: StatsTabViewController())
        let thirdTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "chart.bar"), tag: 2)
        if let image = UIImage(systemName: "chart.bar", withConfiguration: UIImage.SymbolConfiguration(weight: .medium)) {
            thirdTabBarItem.image = image.imageWithoutBaseline()
        }
        thirdTab.tabBarItem = thirdTabBarItem
        
        let forthTab = UINavigationController(rootViewController: SettingViewController())
        let forthTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape"), tag: 3)
        if let image = UIImage(systemName: "gearshape", withConfiguration: UIImage.SymbolConfiguration(weight: .medium)) {
            forthTabBarItem.image = image.imageWithoutBaseline()
        }
        forthTab.tabBarItem = forthTabBarItem
        
        self.viewControllers = [firstTab, secondTab, thirdTab, forthTab]
        
    }
}
