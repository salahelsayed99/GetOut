//
//  CategoryViewModelController.swift
//  Get Me Out
//
//  Created by Salah  on 27/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation
protocol CategoryViewModelControllerDelegate {
    func sendCategory(_ data:[CategoryViewModel])
}

class CategoryViewModelController{
    
    var categoriesArray = [CategoryViewModel]()
    var delegate:CategoryViewModelControllerDelegate?
    
    
    func fetchData(){
        DispatchQueue.global(qos: .userInitiated).async {

        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/category") { (info:Welcome) in
            if info.statusCode == 200{
                self.categoriesArray = info.categories.map({return CategoryViewModel(cell: $0)})
                self.delegate?.sendCategory(self.categoriesArray)
            }
            }
            
        }
        
        
        
    }
    
    
    
    
}




