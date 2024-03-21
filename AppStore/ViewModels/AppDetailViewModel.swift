//
//  AppDetailViewModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 8.03.2024.
//

import Foundation
import UIKit

struct AppDetailViewModel {
    let result: DetailResult
    init(result: DetailResult) {
        self.result = result
    }
    var name: String? {
        return result.trackName
    }
    var releaseNotes: String? {
        return result.releaseNotes
    }
    var appImageUrl: URL? {
        return URL(string: result.artworkUrl100)
    }
    var formattedPrice: String? {
        return result.formattedPrice
    }
    var screenshotUrls: [URL]? {
        return result.screenshotUrls.compactMap { URL(string: $0) }
    }
}

