//
//  ReusableImageView.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/22/23.
//

import UIKit

class ReusableImageView: UIImageView {

  // MARK: Lifecyle
   override init(frame: CGRect) {
     super.init(frame: frame)
     configure()
   }
   
   required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
   }
   
   init() {
     super.init(frame: .zero)
     configure()
   }
   
   // MARK: Helping Functions
   private func configure() {
     contentMode = .scaleAspectFit
     layer.cornerRadius = 10
     clipsToBounds = true
     layer.masksToBounds = true
     translatesAutoresizingMaskIntoConstraints = false
   }

}
