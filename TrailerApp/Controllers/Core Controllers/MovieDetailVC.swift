//
//  MovieDetailVC.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/20/23.
//

import UIKit
import WebKit

class MovieDetailVC: UIViewController {

  // MARK: Properties
  private let posterImageView = ReusableImageView()
  private let movieTitle = ReusableLabel(text: nil, fontSize: 18, weight: .semibold, color: .label, numberOfLines: 0)
  private let movieDescription = ReusableLabel(text: nil, fontSize: 15, weight: .regular, color: .label, numberOfLines: 0)
  private let webview = WKWebView()
  private var vStack: UIStackView!
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureProperties()
    configureConstraints()
  }
    
  // MARK: Helping Functions
  private func configureNavBar() {
    navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
  }
  
  private func configureProperties() {
    view.addSubview(posterImageView)

    vStack = UIStackView(arrangedSubviews: [movieTitle, movieDescription])
    view.addSubview(vStack)
    vStack.translatesAutoresizingMaskIntoConstraints = false
    vStack.axis = .vertical
    vStack.spacing = 20
    vStack.distribution = .fill
    vStack.alignment = .center

    movieTitle.textAlignment = .center
    movieDescription.textAlignment = .center
    
    view.addSubview(webview)
    webview.backgroundColor = .systemBackground
    webview.translatesAutoresizingMaskIntoConstraints = false
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
      webview.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 20),
      webview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      webview.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
      webview.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  public func configure(with movie: [MovieInformation], indexPath: Int) {
    guard let poster = movie[indexPath].posterPath else { return }
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else { return }
    
    self.posterImageView.sd_setImage(with: url)
    self.movieTitle.text = movie[indexPath].originalTitle
    self.movieDescription.text = movie[indexPath].overview
    
    YoutubeManager.shared.getMovieTrailer(with: movie[indexPath].originalTitle ?? "") { [weak self] result in
      switch result {
      case .success(let videoInfo):
        DispatchQueue.main.async {
          guard let url = URL(string: "https://www.youtube.com/embed/\(videoInfo.id.videoId)") else { return }
          self?.webview.load(URLRequest(url: url))
        }
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
}
