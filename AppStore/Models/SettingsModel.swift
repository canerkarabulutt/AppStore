//
//  SettingsModel.swift
//  AppStore
//
//  Created by Caner Karabulut on 15.03.2024.
//

import Foundation

struct Section {
    let title : String?
    var options : [Option]
}

struct Option {
    let title : String
}
