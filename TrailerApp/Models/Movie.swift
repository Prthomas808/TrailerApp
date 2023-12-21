//
//  Movie.swift
//  TrailerApp
//
//  Created by Pedro Thomas on 12/21/23.
//

import Foundation

struct Movie: Codable {
  let results: [MovieInformation]
}

struct MovieInformation: Codable {
  let originalTitle: String?
  let overview: String?
  let posterPath: String?
  let releaseDate: String?
  let title: String?
  let voteAverage: Double
  let voteCount: Int
}
