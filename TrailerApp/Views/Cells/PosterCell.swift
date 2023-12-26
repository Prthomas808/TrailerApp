//
//  PosterCell.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/26/23.
//

import UIKit
import SDWebImage

class PosterCell: UICollectionViewCell {
    
  // MARK: Properties
  static let reusableID = "PosterCell"
  
  private let posterImageView = ReusableImageView()
//  private let posterImageView = UIButton()
  
  // MARK: Lifecyle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Helping Functions
  private func configure() {
    contentView.addSubview(posterImageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    posterImageView.frame = self.bounds
  }
  
  public func configure(with movie: [MovieInformation], indexPath: Int) {
    guard let poster = movie[indexPath].posterPath else { return }
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else { return }
    
    self.posterImageView.sd_setImage(with: url)
  }
}
