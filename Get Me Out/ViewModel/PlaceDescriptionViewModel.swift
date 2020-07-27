//
//  PlaceDescriptionViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 27/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation


struct PlaceDescriptionViewModel {
    
    
    let placeID: String
    let id: Int
    let name:String
    var shortDesc: String
    let imageurl: String
    let rateAvg: Double
    let numOfRater: Int
    let latitude:Double
    var longitude: Double
    let images: [ImageElement]
    let rates: [Rate]
    let mobile: String
    let isbookmarked: Int
    
    
    init(place:Place) {
        placeID = place.placeID
        id = place.id
        name = place.name
        shortDesc = place.shortDesc
        imageurl = place.imageurl
        rateAvg = place.rateAvg
        numOfRater = place.numOfRater
        latitude = place.latitude
        longitude = place.longitude
        images = place.images
        rates = place.rates
        mobile = place.mobile
        isbookmarked = place.isbookmarked
    }
    
    
}
