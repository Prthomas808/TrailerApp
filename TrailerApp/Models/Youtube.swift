//
//  Youtube.swift
//  Trailers
//
//  Created by Pedro Thomas on 11/25/23.
//

import Foundation

struct YoutubeResponse: Codable {
    let items: [VideoInfo]
}

struct VideoInfo: Codable {
    let id: ID
}

struct ID: Codable {
    let videoId: String
}
