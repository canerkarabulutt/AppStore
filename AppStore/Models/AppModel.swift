//
//  AppModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import Foundation

struct AppModel: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let results: [AppResults]
}

struct AppResults: Codable {
    let artistName: String
    let id: String
    let name: String
    let artworkUrl100: URL
}

