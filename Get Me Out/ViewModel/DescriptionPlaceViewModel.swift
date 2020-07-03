//
//  DescriptionPlaceViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 27/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

protocol passPlaceData {
    func passData(data:Place)
}

class DescriptionPlaceViewModel{
    var passDataDelegate:passPlaceData?
    
    
    
    func fetchData(_ id:Int){
        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/place?lang=ar&place_id=\(id)") { (data:PlaceDescription) in
            if data.statusCode == 200{
                self.passDataDelegate?.passData(data: data.place)
                print(data.place.name)
            }
        }
    }
    
}
