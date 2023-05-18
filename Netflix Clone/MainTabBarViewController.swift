//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow /* 2 */

        let vc1 = UINavigationController(rootViewController: HomeViewController()) /* 11 */
        let vc2 = UINavigationController(rootViewController: UpcomingViewController()) /* 12 */
        let vc3 = UINavigationController(rootViewController: SearchViewController()) /* 13 */
        let vc4 = UINavigationController(rootViewController: DownloadsViewController()) /* 14 */
        
        vc1.tabBarItem.image = UIImage(systemName: "house") /* 16 */
        vc2.tabBarItem.image = UIImage(systemName: "play.circle") /* 17 */
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass") /* 18 */
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line") /* 19 */
        
        vc1.title = "Home" /* 20 */
        vc2.title = "Coming Soon" /* 21 */
        vc3.title = "Top Search" /* 22 */
        vc4.title = "Downloads" /* 23 */
        
        tabBar.tintColor = .label /* 24 */
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true) /* 15 */
        
    }
 

}

