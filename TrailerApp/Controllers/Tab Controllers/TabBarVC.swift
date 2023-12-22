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
    let vc3 = UINavigationController(rootViewController: SearchMovieVC())
    
    vc1.tabBarItem.image = UIImage(systemName: "film")
    vc2.tabBarItem.image = UIImage(systemName: "popcorn")
    vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    
    vc1.title = "Movies"
    vc2.title = "Coming Soon"
    vc3.title = "Search"
    
    setViewControllers([vc1, vc2, vc3], animated: true)
  }
}
