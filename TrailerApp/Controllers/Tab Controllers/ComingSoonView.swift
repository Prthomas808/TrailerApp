//
//  ComingSoonView.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/20/23.
//

import UIKit

class ComingSoonView: UIViewController {

  // MARK: Properties
  private var collectionView: UICollectionView!
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureCollectionView()
  }

  // MARK: Helping Functions
  private func configureNavBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
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

extension ComingSoonView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusableID, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
    
    TMDBManager.shared.fetchTMDBInfo(endpoint: "movie/upcoming") { result in
      switch result {
      case .success(let movie):
        DispatchQueue.main.async { cell.configure(with: movie, indexPath: indexPath.row) }
      case .failure(let error):
        print(error.rawValue)
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = MovieDetailVC()
    
    TMDBManager.shared.fetchTMDBInfo(endpoint: "movie/upcoming") { result in
      switch result {
      case .success(let movie):
        DispatchQueue.main.async {
          vc.configure(with: movie, indexPath: indexPath.row)
        }
        
      case .failure(let error): print(error.rawValue)
      }
    }
    
    navigationController?.pushViewController(vc, animated: true)
  }
}
