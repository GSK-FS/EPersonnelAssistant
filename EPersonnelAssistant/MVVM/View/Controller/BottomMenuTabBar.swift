//
//  BottomMenuTabBar.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/9/21.
//

import UIKit

open class BottomMenuTabBar: UITabBarController {
    let navTitleArray = ["History", "Profile", "Services"]
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        //let layout = UICollectionViewFlowLayout()
        let dashBoardController = UserDashBoardViewController()
        let dashboardHomeNavController = UINavigationController(rootViewController: dashBoardController)
        dashboardHomeNavController.tabBarItem.title = "Dashboard"
        dashboardHomeNavController.tabBarItem.image = UIImage(named: "home_24_icon_c")?.withRenderingMode(.alwaysOriginal)
        
        
        
        viewControllers = [dashboardHomeNavController, createNavController(title: "History", image: "history_24_icon_c"), createNavController(title: "Profile", image: "profile_24_icon_c"), createNavController(title: "Services", image: "services_24_icon_c")]
        
    }
     open var isBottomBarHidden: Bool = true
    func createNavController(title: String, image: String) -> UINavigationController {
        let viewController = HistoryViewController()//UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        
        return navController
    }
}
