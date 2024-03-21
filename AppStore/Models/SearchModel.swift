//
//  SearchModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 7.03.2024.
//

import Foundation

struct SearchModel: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let primaryGenreName: String
    let artworkUrl100: String
    let trackName: String
    let screenshotUrls: [String]
    var averageUserRating: Float?
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
    var trackId: Int?
}

