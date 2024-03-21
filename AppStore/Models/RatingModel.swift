//
//  RatingModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 12.03.2024.
//

import Foundation

struct RatingModel: Codable {
    let feed: RatingFeed
}

struct RatingFeed: Codable {
    let entry: [Entry]
}
struct Entry: Codable {
    let author: Author
    let title: Label
    let content: Label
    let rating: Label
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case content
        case rating = "im:rating"
    }
}
struct Author: Codable {
    let name: Label
}
struct Label: Codable {
    let label: String
}

