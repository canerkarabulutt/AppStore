//
//  TodayDetailViewModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 19.03.2024.
//

import Foundation
import UIKit

struct TodayDetailViewModel {
    let today: Today
    init(today: Today) {
        self.today = today
    }
    
    var title1: NSMutableAttributedString {
        return attributedTitle(title: today.detailTitle1, description: today.description1)
    }
    
    var title2: NSMutableAttributedString {
        return attributedTitle(title: today.detailTitle2, description: today.description2)
    }
    
    private func attributedTitle(title: String, description: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)])
        attributedString.append(NSAttributedString(string: description, attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.boldSystemFont(ofSize: 18)]))
        return attributedString
    }
}
