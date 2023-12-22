//
//  TMDBManager.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/21/23.
//

import Foundation

class TMDBManager {
  
  static let shared = TMDBManager()
  
  let apiKey =  "9289e49bd9aaa2673be7014b9af0cfd8"
  
  func fetchTMDBInfo(endpoint: String, completion: @escaping (Result<[MovieInformation], TrailerError>) -> Void) {
    guard let url = URL(string: "https://api.themoviedb.org/3/\(endpoint)?api_key=\(apiKey)") else {
      completion(.failure(.invalidURL))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completion(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completion(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let movie = try decoder.decode(Movie.self, from: data)
        completion(.success(movie.results))
      } catch {
        completion(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
}

enum TrailerError: String, Error {
  case invalidURL = "This URL is invalid"
  case invalidResponse = "There was a response error"
  case invalidData = "There was an error with the data returned"
  case unableToComplete = "The task was not able to be completed"
}
