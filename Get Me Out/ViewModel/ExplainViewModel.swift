//
//  ExplainViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 23/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation


//protocol ExplainViewModelDelegate {
//    func sendCategories(_ data:[CategoryElement])
//}

struct ExplainViewModel {
    
    var id: Int
    var name: String
    var places: Places
    
    
    
    
    
    init(row:CategoryElement) {
        id = row.id
        name = row.name
        places = row.places
    }
    
    
//    var delegate:ExplainViewModelDelegate?
//
//
//    func fetchData(){
//       DispatchQueue.global(qos: .userInteractive).async {
//
//            Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/home_categories?lang=ar") { (info:Category) in
//                     if info.statusCode == 200{
//                         self.delegate?.sendCategories(info.categories)
//                     }
//
//            }
//
//        }
//
//    }
    
    
    
    
    
    
    
}
