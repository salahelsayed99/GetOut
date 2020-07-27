//
//  SignInAndUp.swift
//  Get Me Out
//
//  Created by Salah  on 02/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

// MARK: - SignIn
struct SignIn: Codable {
    let user: User
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case user
        case statusCode = "status_code"
        case key
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let email, mobile, fullName, latitude: String
    let longitude, lang, active, banned: String
    let image: String
    let cityID, addPlaces: Int
    let address, jwt: String
    let imageurl, imageurlorg: String
    let token: Token

    enum CodingKeys: String, CodingKey {
        case id, email, mobile
        case fullName = "full_name"
        case latitude, longitude, lang, active, banned, image
        case cityID = "city_id"
        case addPlaces = "add_places"
        case address, jwt, imageurl, imageurlorg, token
    }
}

// MARK: - Token
struct Token: Codable {
    let userID: Int
    let deviceType, jwt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case deviceType = "device_type"
        case jwt
    }
}



// MARK: - Signup
struct Signup: Codable {
    let user: User1
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case user
        case statusCode = "status_code"
        case key
    }
}

// MARK: - User
struct User1: Codable {
    let email, mobile, fullName, cityID: String
    let lang, active: String
    let id: Int
    let jwt: String
    let imageurl, imageurlorg: String

    enum CodingKeys: String, CodingKey {
        case email, mobile
        case fullName = "full_name"
        case cityID = "city_id"
        case lang, active, id, jwt, imageurl, imageurlorg
    }
}


// MARK: - Cityes
struct Cityes: Codable {
    let cities: [City]
    let statusCode: Int
    let key: String

    enum CodingKeys: String, CodingKey {
        case cities
        case statusCode = "status_code"
        case key
    }
}



// MARK: - City
struct City: Codable {
    let id, countryID: Int
    let name: String
    let country: Country

    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case name, country
    }
}

// MARK: - Country
struct Country: Codable {
    let id: Int
    let nameAr: NameAr
    let nameEn: NameEn
    let telKey: Int
    let continent: Continent
    let image: String

    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case telKey = "tel_key"
        case continent, image
    }
}

enum Continent: String, Codable {
    case africa = "Africa"
}

enum NameAr: String, Codable {
    case مصر = "مصر"
}

enum NameEn: String, Codable {
    case egypt = "Egypt"
}
