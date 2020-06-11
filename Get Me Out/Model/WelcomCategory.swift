//
//  WelcomCategory.swift
//  Get Me Out
//
//  Created by zeyad on 6/5/20.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let categories: [WelcomCategory]
    let statusCode: Int
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case categories
        case statusCode = "status_code"
        case key
    }
}

//// MARK: - Category
struct WelcomCategory: Codable {
    let id: Int
    let image, name: String
    let shortDesc: ShortDesc1
    let imageurl: String

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case shortDesc = "short_desc"
        case imageurl
    }
}

enum ShortDesc1: String, Codable {
    case e = "e"
    case empty = ""
}
