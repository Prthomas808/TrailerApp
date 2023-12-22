//
//  SearchMovieVC.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/22/23.
//

import UIKit

class SearchMovieVC: UIViewController {

  // MARK: Properties
  private let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
  }

  // MARK: Helping Functions
  private func configureNavBar() {
    title = "Search"
    navigationItem.searchController = searchController
  }
}
