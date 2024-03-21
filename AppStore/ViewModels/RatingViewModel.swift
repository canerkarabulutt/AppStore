//
//  RatingViewModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 12.03.2024.
//

import Foundation

struct RatingViewModel {
    let result: Entry
    init(result: Entry) {
        self.result = result
    }
    var userText: String? {
        return result.author.name.label
    }
    var titleText: String? {
        return result.title.label
    }
    var bodyText: String? {
        return result.content.label
    }
    var ratingText: String? {
        var resultText = ""
        let count = Int(result.rating.label) ?? 0
        for _ in 0...count {
            resultText.append("⭐️")
        }
        return resultText
    }
}

