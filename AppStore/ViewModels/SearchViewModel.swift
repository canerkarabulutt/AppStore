//
//  SearchViewModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 7.03.2024.
//

import Foundation

struct SearchCellViewModel {
    let result: SearchResult
    init(result: SearchResult) {
        self.result = result
    }
    var ratingLabel: String? {
        return String(format: "%.2f", result.averageUserRating ?? 0)
    }
    var nameLabel: String? {
        return result.trackName
    }
    var categoryLabel: String? {
        return result.primaryGenreName
    }
    var appImage: URL? {
        return URL(string: result.artworkUrl100)
    }
    var screenPage1: URL? {
        return URL(string: result.screenshotUrls[0])
    }
    var screenPage2: URL? {
        if result.screenshotUrls.count > 1 {
            return URL(string: result.screenshotUrls[1])
        } else {
            return URL(string: result.screenshotUrls[0])
        }
    }
    var screenPage3: URL? {
        if result.screenshotUrls.count > 1 {
            return URL(string: result.screenshotUrls[2])
        } else {
            return URL(string: result.screenshotUrls[0])
        }
    }
}
