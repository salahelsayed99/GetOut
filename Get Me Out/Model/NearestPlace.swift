//
//  ChoosenPlace.swift
//  Get Me Out
//
//  Created by Salah  on 20/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation


// MARK: - NearestPlace
struct NearestPlace: Codable {
    let category: NearestCategory
    let places: NearestPlaces
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case category, places
        case statusCode = "status_code"
        case key
    }
}

// MARK: - Category
struct NearestCategory: Codable {
    let id: Int?
    let image, name, shortDesc: String
    let imageurl: String

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case shortDesc = "short_desc"
        case imageurl
    }

    }


// MARK: - Places
struct NearestPlaces: Codable {
    let currentPage: Int
    let data: [DatumNearest]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL, path: String
    let nextPageURL:String?
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }

}

// MARK: - Datum
struct DatumNearest: Codable {
    let id: Int
    let name: String
    let rateAvg: Double
    let numOfRater: Int
    let latitude, longitude: Double
    let shortDesc, address: String
    let imageurl: String
    let isbookmarked: Int
    let dashboardurl: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case rateAvg = "rate_avg"
        case numOfRater = "num_of_rater"
        case latitude, longitude
        case shortDesc = "short_desc"
        case address, imageurl, isbookmarked, dashboardurl
    }
}
