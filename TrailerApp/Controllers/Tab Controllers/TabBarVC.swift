//
//  TabBarVC.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/20/23.
//

import UIKit

class TabBarVC: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let vc1 = UINavigationController(rootViewController: TrendingMovieView())
    let vc2 = UINavigationController(rootViewController: ComingSoonView())
    
    vc1.tabBarItem.image = UIImage(systemName: "film")
    vc2.tabBarItem.image = UIImage(systemName: "popcorn")
    
    vc1.title = "Movies"
    vc2.title = "Coming Soon"
    
    setViewControllers([vc1, vc2], animated: true)
  }
}
