//
//  SearchResultsVC.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/26/23.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject {
  func didSelectMovie(at movie: MovieInformation)
}

class SearchResultsVC: UIViewController {

  // MARK: Properties
  public var collectionView: UICollectionView!
  public var movies: [MovieInformation] = []
  private let viewModel = TrailerAppVIewModel()
  weak var delegate: SearchResultsVCDelegate?
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureCollectionView()
  }
  
  // MARK: Helping Functions
  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.addSubview(collectionView)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reusableID)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}

extension SearchResultsVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reusableID, for: indexPath) as? PosterCell else { return UICollectionViewCell() }
    
    cell.configure(with: movies, indexPath: indexPath.row)

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedMovie = movies[indexPath.row]
    delegate?.didSelectMovie(at: selectedMovie)
  }
}

extension SearchResultsVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 175)
  }
}
