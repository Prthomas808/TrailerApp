//
//  TrailerAppVIewModel.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/21/23.
//

import Foundation
import WebKit

class TrailerAppVIewModel {
  
  func fetchMovie(endpoint: String ,completion: @escaping ([MovieInformation]) -> Void) {
    TMDBManager.shared.fetchTMDBInfo(endpoint: endpoint) { result in
      switch result {
      case .success(let movie):
        DispatchQueue.main.async {
          completion(movie)
        }
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }

}
