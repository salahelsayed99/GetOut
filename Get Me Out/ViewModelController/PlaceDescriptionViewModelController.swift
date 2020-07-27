//
//  PlaceDescriptionViewModelController.swift
//  Get Me Out
//
//  Created by Salah  on 27/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

protocol PlaceDescriptionViewModelControllerDelegate {
    func sendPlaceDescriptionData(_ data:PlaceDescriptionViewModel)
}


class PlaceDescriptionViewModelController{
    

    var delegate:PlaceDescriptionViewModelControllerDelegate?
    
      func fetchData(id:Int){
        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/place?lang=ar&place_id=\(id)") { (data:PlaceDescription) in
            if data.statusCode == 200{
                self.delegate?.sendPlaceDescriptionData(PlaceDescriptionViewModel(place: data.place))
            }
        }
        
    }
    
    
}
