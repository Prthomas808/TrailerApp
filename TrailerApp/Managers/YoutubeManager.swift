//
//  YoutubeManager.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/21/23.
//

import Foundation

class YoutubeManager {
  static let shared = YoutubeManager()
  let YoutubeApiKey = "AIzaSyB1UEaN8ifaVpsVK3w32pGexKf8QTLqZw4"
  
  func getMovieTrailer(with query: String, completion: @escaping (Result<VideoInfo, TrailerError>) -> Void) {
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    
    let endpoint = "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(YoutubeApiKey)"
    
    guard let url = URL(string: endpoint) else {
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
        let trailer = try decoder.decode(YoutubeResponse.self, from: data)
        completion(.success(trailer.items[0]))
      } catch {
        completion(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
}
