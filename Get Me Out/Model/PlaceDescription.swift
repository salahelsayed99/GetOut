//
//  PlaceDescription.swift
//  Get Me Out
//
//  Created by Salah  on 27/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

struct PlaceDescription: Codable {
    let place: Place
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case place
        case statusCode = "status_code"
        case key
    }
}

// MARK: - Place
struct Place: Codable {
    let placeID: String
    let id: Int
    let name, shortDesc, address: String
    let imageurl: String
    let rateAvg: Double
    let numOfRater: Int
    let latitude, longitude: Double
    let other: String
    let images: [ImageElement]
    let menus: [String]
    let rates: [Rate]
    let mobile, firstTimeOpen, firstTimeClose: String
    let isbookmarked: Int
    let isHaveOffer: String

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case id, name
        case shortDesc = "short_desc"
        case address, imageurl
        case rateAvg = "rate_avg"
        case numOfRater = "num_of_rater"
        case latitude, longitude, other, images, menus, rates, mobile
        case firstTimeOpen = "first_time_open"
        case firstTimeClose = "first_time_close"
        case isbookmarked
        case isHaveOffer = "is_have_offer"
    }
}

// MARK: - ImageElement
struct ImageElement: Codable {
    let id, placeID: Int
    let image: String?
    let imageurl, imageorg: String

    enum CodingKeys: String, CodingKey {
        case id
        case placeID = "place_id"
        case image, imageurl, imageorg
    }
}

// MARK: - Rate
struct Rate: Codable {
    let id, userID, placeID: Int
    let stars: Double
    let comment: String
    let user: UserPlaceDescripion

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case placeID = "place_id"
        case stars, comment, user
    }
}

// MARK: - User
struct UserPlaceDescripion: Codable {
    let id: Int
    let image: String?
    let email: String
    let mobile: String?
    let fullName, latitude, longitude, address: String
    let imageurl, imageurlorg: String

    enum CodingKeys: String, CodingKey {
        case id, image, email, mobile
        case fullName = "full_name"
        case latitude, longitude, address, imageurl, imageurlorg
    }
}

