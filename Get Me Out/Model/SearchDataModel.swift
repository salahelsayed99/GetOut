//
//  SearchDataModel.swift
//  Get Me Out
//
//  Created by Salah  on 07/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

struct SearchDataModel{
    var id: Int
    var name: String
    var rateAvg, numOfRater: Int
    var latitude, longitude: Double
    var shortDesc, address: String
    var imageurl: String
    var isbookmarked: Int
    var dashboardurl: String
    var images: [Image]
}
