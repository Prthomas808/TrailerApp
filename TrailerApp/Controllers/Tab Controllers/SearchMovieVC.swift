//
//  SearchMovieVC.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/22/23.
//

import UIKit

class SearchMovieVC: UIViewController {

  // MARK: Properties
  private let searchController = UISearchController(searchResultsController: SearchResultsVC())
  private var collectionView: UICollectionView!
  private let viewModel = TrailerAppVIewModel()
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureCollectionView()
  }

  // MARK: Helping Functions
  private func configureNavBar() {
    title = "Search"
    navigationItem.searchController = searchController
    searchController.searchBar.tintColor = .systemRed
    searchController.searchResultsUpdater = self
    
    if let resultsController = searchController.searchResultsController as? SearchResultsVC {
            resultsController.delegate = self
        }
  }
  
  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.addSubview(collectionView)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reusableID)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}

extension SearchMovieVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 10 }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusableID, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
    
    viewModel.fetchMovie(endpoint: "movie/popular") { movie in
      cell.configure(with: movie, indexPath: indexPath.row)
    }

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = MovieDetailVC()
    
    viewModel.fetchMovie(endpoint: "movie/popular") { movie in
      vc.configure(with: movie, indexPath: indexPath.row)
      
      
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension SearchMovieVC: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    
    guard let query = searchBar.text,
          !query.trimmingCharacters(in: .whitespaces).isEmpty,
          query.trimmingCharacters(in: .whitespaces).count >= 3,
          let resultsController = searchController.searchResultsController as? SearchResultsVC else {
      return
    }
    
    TMDBManager.shared.searchMovie(query: query) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let movie):
          resultsController.movies = movie
          resultsController.collectionView.reloadData()
        case .failure(let error): print(error.rawValue)
        }
      }
    }
  }
}

extension SearchMovieVC: SearchResultsVCDelegate {
  func didSelectMovie(at movie: MovieInformation) {
    let vc = MovieDetailVC()
    vc.configure(with: [movie], indexPath: 0)
    navigationController?.pushViewController(vc, animated: true)
  }
}
