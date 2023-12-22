//
//  TMDBManager.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/21/23.
//

import Foundation

enum TrailerError: String, Error {
  case invalidURL = "This URL is invalid"
  case invalidResponse = "There was a response error"
  case invalidData = "There was an error with the data returned"
  case unableToComplete = "The task was not able to be completed"
}

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

extension TMDBManager {
  func searchMovie(query: String, completion: @escaping (Result<[MovieInformation], TrailerError>) -> Void) {
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    
    let endpoint = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)"
    
    guard let url = URL(string: endpoint) else { return }
    
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
//        let movie = try JSONSerialization.jsonObject(with: data)
//        print(movie)
      } catch {
        completion(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
}
