//
//  MovieDetailVC.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/20/23.
//

import UIKit

class MovieDetailVC: UIViewController {

  // MARK: Properties
  private let posterImageView = UIImageView()
  private let movieTitle = ReusableLabel(text: nil, fontSize: 18, weight: .semibold, color: .label, numberOfLines: 0)
  private let movieDescription = ReusableLabel(text: nil, fontSize: 15, weight: .regular, color: .label, numberOfLines: 0)
  private let trailerButton = ReusableButton(buttonTitle: "Watch Trailer", textColor: .white, buttonColor: .systemRed)
  private var vStack: UIStackView!
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureProperties()
    configureConstraints()
  }
  
  // MARK: Objc Functions
  
  
  // MARK: Helping Functions
  private func configureNavBar() {
    navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
  }
  
  private func configureProperties() {
    view.addSubview(posterImageView)
    posterImageView.contentMode = .scaleAspectFit
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    vStack = UIStackView(arrangedSubviews: [movieTitle, movieDescription])
    view.addSubview(vStack)
    vStack.translatesAutoresizingMaskIntoConstraints = false
    vStack.axis = .vertical
    vStack.spacing = 20
    vStack.distribution = .fill
    vStack.alignment = .center

    movieTitle.textAlignment = .center
    movieDescription.textAlignment = .center
    
    view.addSubview(trailerButton)
  }
  
  private func configureConstraints() {
    // Poster constraints
    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
      posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      posterImageView.heightAnchor.constraint(equalToConstant: 200),
      posterImageView.widthAnchor.constraint(equalToConstant: 150)
    ])
    
    // vStack constraints
    NSLayoutConstraint.activate([
      vStack.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
      vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
      vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
    ])
    
    // Button constraints
    NSLayoutConstraint.activate([
      trailerButton.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 20),
      trailerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      trailerButton.widthAnchor.constraint(equalToConstant: 200),
      trailerButton.heightAnchor.constraint(equalToConstant: 45)
    ])
  }
  
  public func configure(with movie: [MovieInformation], indexPath: Int) {
    guard let poster = movie[indexPath].posterPath else { return }
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else { return }
    
    self.posterImageView.sd_setImage(with: url)
    
    self.movieTitle.text = movie[indexPath].originalTitle
    self.movieDescription.text = movie[indexPath].overview
  }
}
