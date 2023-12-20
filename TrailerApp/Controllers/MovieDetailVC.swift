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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  // MARK: Objc Functions
  
  
  // MARK: Helping Functions
  private func configureNavBar() {
    navigationController?.navigationBar.topItem?.backButtonTitle = "Bsck"
    
  }
  
  private func configureProperties() {
    view.addSubview(posterImageView)
    posterImageView.contentMode = .scaleAspectFit
    posterImageView.backgroundColor = .systemGray5
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    vStack = UIStackView(arrangedSubviews: [movieTitle, movieDescription])
    view.addSubview(vStack)
    vStack.translatesAutoresizingMaskIntoConstraints = false
    vStack.axis = .vertical
    vStack.spacing = 20
    vStack.distribution = .fill
    vStack.alignment = .center

    movieTitle.text = "The Hunger Games: Catching Fire"
    
    movieDescription.text = "Katniss Everdeen and Peeta Mellark become targets of the Capitol after their victory in the 74th Hunger Games sparks a rebellion in the Districts of Panem."
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
      vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    
    // Button constraints
    NSLayoutConstraint.activate([
      trailerButton.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 20),
      trailerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      trailerButton.widthAnchor.constraint(equalToConstant: 200),
      trailerButton.heightAnchor.constraint(equalToConstant: 45)
    ])
  }
}
