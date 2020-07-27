//
//  SearchViewModelController.swift
//  Get Me Out
//
//  Created by Salah  on 27/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

protocol SearchViewModelControllerDelegate {
    func sendSearchResults(_ data:[SearchViewModel])
}


class SearchViewModelController{
    
    
    var delegate:SearchViewModelControllerDelegate?
    
    func fetchData(searchTarget:String){
        DispatchQueue.global(qos: .userInitiated).async {
            
            Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/search?lang=ar&name=\(searchTarget)") { (info:SearchInformation) in
                self.delegate?.sendSearchResults(info.places.data.map({return SearchViewModel(place: $0)}))
                    
            }
        }
        
        
        
    }
    
    
}
