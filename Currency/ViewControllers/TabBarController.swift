//
//  TabBarController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let tabBarItemPadding: CGFloat = -30
}

final class TabBarContoller: UITabBarController {
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(CustomTabBar(), forKey: "tabBar")
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = .white
        
        let imageInsets = UIEdgeInsets(top: 0,
                                       left: 0,
                                       bottom: Constants.tabBarItemPadding,
                                       right: 0)
        
        let firstViewController = CurrenciesViewController()
        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Currencies"), tag: 0)
        firstViewController.tabBarItem.imageInsets = imageInsets
        
        let secondViewController = FavouriteViewController()
        secondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Favourite"), tag: 1)
        secondViewController.tabBarItem.imageInsets = imageInsets
        
        let thirdViewController = CurrenciesViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Notification"), tag: 2)
        thirdViewController.tabBarItem.imageInsets = imageInsets
        
        let fourthViewController = CurrenciesViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Policy"), tag: 3)
        fourthViewController.tabBarItem.imageInsets = imageInsets
        
        viewControllers = [firstViewController, 
                           secondViewController,
                           thirdViewController,
                           fourthViewController]
    }
}
