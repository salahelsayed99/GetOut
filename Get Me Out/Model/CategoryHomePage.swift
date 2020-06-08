//
//  CategoryHomePage.swift
//  Get Me Out
//
//  Created by Salah  on 03/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

class Category: Codable {
    let categories: [CategoryElement]
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case categories
        case statusCode = "status_code"
        case key
    }
}

// MARK: - CategoryElement
class CategoryElement: Codable {
    let id: Int
    let seeMoreAPIURL: String
    let image: String
    let name: String
    let shortDesc: ShortDesc
    let imageurl: String
    let places: Places

    enum CodingKeys: String, CodingKey {
        case id
        case seeMoreAPIURL = "see_more_api_url"
        case image, name
        case shortDesc = "short_desc"
        case imageurl, places
    }
}

// MARK: - Places
class Places: Codable {
    let data: [Datum]
    let perPage: Int

    enum CodingKeys: String, CodingKey {
        case data
        case perPage = "per_page"
    }
}



// MARK: - Datum
class Datum: Codable {
    let id: Int
    let name: String
    let rateAvg: Double
    let numOfRater: Int
    let latitude, longitude: Double
    let shortDesc, address: String
    let imageurl: String
    let isbookmarked: Int
    let dashboardurl: String
    let pivot: Pivot?

    enum CodingKeys: String, CodingKey {
        case id, name
        case rateAvg = "rate_avg"
        case numOfRater = "num_of_rater"
        case latitude, longitude
        case shortDesc = "short_desc"
        case address, imageurl, isbookmarked, dashboardurl, pivot
    }
}

// MARK: - Pivot
class Pivot: Codable {
    let categoryID, placeID: Int

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case placeID = "place_id"
    }
}

enum ShortDesc: String, Codable {
    case e = "e"
    case empty = ""
    case أحدثالاضافات = "أحدث الاضافات"
}
