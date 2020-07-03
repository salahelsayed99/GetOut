//
//  SearchCategoryHomePage.swift
//  Get Me Out
//
//  Created by Salah  on 07/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

struct SearchInformation: Codable {
    let places: PlacesSearch
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case places
        case statusCode = "status_code"
        case key
    }
}

struct PlacesSearch: Codable {
    let currentPage: Int
    let data: [DatumSearch]
    let firstPageURL: String
    let from : Int?
    let lastPage: Int
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to : Int?
    let total: Int

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


struct DatumSearch: Codable {
    let id: Int?
    let name: String
    let rateAvg : Double
    let numOfRater: Int
    let latitude, longitude: Double
    let shortDesc, address: String
    let imageurl: String
    let isbookmarked: Int
    let dashboardurl: String
    let images: [Image]

    enum CodingKeys: String, CodingKey {
        case id, name
        case rateAvg = "rate_avg"
        case numOfRater = "num_of_rater"
        case latitude, longitude
        case shortDesc = "short_desc"
        case address, imageurl, isbookmarked, dashboardurl, images
    }
}


// MARK: - Image
struct Image: Codable {
    let id, placeID: Int
    let image: String
    let imageurl, imageorg: String

    enum CodingKeys: String, CodingKey {
        case id
        case placeID = "place_id"
        case image, imageurl, imageorg
    }
}
