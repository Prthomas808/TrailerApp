//
//  MovieCell.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/20/23.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
  // MARK: Properties
  static let reusableID = "MovieCell"
  
  private let posterImageView = UIImageView()
  private let movieName = ReusableLabel(text: nil, fontSize: 15, weight: .light, color: .label, numberOfLines: 0)
  
  // MARK: Lifecyle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureProperties()
    configureConstraints()
    layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Objc Functions
  
  
  // MARK: Helping Functions
  private func configureProperties() {
    contentView.addSubview(posterImageView)
    posterImageView.contentMode = .scaleAspectFit
    posterImageView.layer.cornerRadius = 10
    posterImageView.clipsToBounds = true
    posterImageView.layer.masksToBounds = true
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(movieName)
  }
  
  private func configureConstraints() {
    // Poster Constraints
    NSLayoutConstraint.activate([
      posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      posterImageView.heightAnchor.constraint(equalToConstant: 145),
      posterImageView.widthAnchor.constraint(equalToConstant: 100)
    ])
    
    // Movie Title Constraints
    NSLayoutConstraint.activate([
      movieName.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
      movieName.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
      movieName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
    ])
  }
  
  public func configure(with movie: [MovieInformation], indexPath: Int) {
    guard let poster = movie[indexPath].posterPath else { return }
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else { return }
    
    self.posterImageView.sd_setImage(with: url)
    self.movieName.text = movie[indexPath].originalTitle ?? movie[indexPath].title
  }
}
