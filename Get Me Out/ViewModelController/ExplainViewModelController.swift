//
//  ExplainViewModelController.swift
//  Get Me Out
//
//  Created by Salah  on 27/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation
protocol ExplainViewModelControllerDelegate {
    func sendCategories(_ data:[ExplainViewModel])
}

class ExplainViewModelController{
    
    var explainViewModelArray = [ExplainViewModel]()

    var delegate:ExplainViewModelControllerDelegate?

    
    func fetchData(){
       DispatchQueue.global(qos: .userInteractive).async {

            Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/home_categories?lang=ar") { (info:Category) in
                     if info.statusCode == 200{
                        self.explainViewModelArray = info.categories.map({ return ExplainViewModel(row: $0)})

                        self.delegate?.sendCategories(self.explainViewModelArray)
                     }

            }
            
        }

    }
    
    
    
    
}
