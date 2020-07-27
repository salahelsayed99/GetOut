//
//  CategoryViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 24/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

protocol CategoryViewModelDelegate {
    func sendCategory(_ data:[WelcomCategory])
}


struct CategoryViewModel {
    
      var id: Int
      var name: String
      var imageurl: String

    
    init(cell:WelcomCategory) {
        id = cell.id
        name = cell.name
        imageurl = cell.imageurl
    }
    

    
    
    
    
}
