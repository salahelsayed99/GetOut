//
//  SearchViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 23/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation




struct SearchViewModel{
    
    var id: Int?
    var name: String
    var rateAvg : Double
    var numOfRater: Int
    var latitude:Double
    var longitude: Double
    var shortDesc:String
    var imageurl: String
    var isbookmarked: Int
    var images: [Image]
    

    init(place:DatumSearch) {
        id = place.id
        name = place.name
        rateAvg = place.rateAvg
        numOfRater = place.numOfRater
        latitude = place.latitude
        longitude = place.longitude
        shortDesc = place.shortDesc
        imageurl = place.imageurl
        isbookmarked = place.isbookmarked
        images = place.images
    }
    
}
