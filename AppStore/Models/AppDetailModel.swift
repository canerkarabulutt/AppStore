//
//  AppDetailModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 8.03.2024.
//

import Foundation

struct AppDetailModel: Codable {
    let resultCount: Int
    let results: [DetailResult]
    
}

struct DetailResult: Codable {
    let primaryGenreName: String
    let artworkUrl100: String
    let trackName: String
    let screenshotUrls: [String]
    var averageUserRating: Float?
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
    let trackId: Int
}
