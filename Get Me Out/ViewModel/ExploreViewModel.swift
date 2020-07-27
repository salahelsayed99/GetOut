//
//  ExploreViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 24/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit


//protocol ExploreViewModelDelegate {
//    func sendData(_ data:[DatumE])
//    func newFeedLoading(_ newFeed:Bool)
//}

class ExploreViewModel {
    
    var name: String
    var rateAvg: Double
    var imageurl: String
    var id: Int



    init(cell:DatumE) {
        name = cell.name
        rateAvg = cell.rateAvg
        imageurl = cell.imageurl
        id = cell.id!
    }
    
    
    

//    var currentPage:Int = 1
//    var delegate:ExploreViewModelDelegate?

    
//    
//    func fetchData(id:Int){
//        DispatchQueue.global(qos: .userInitiated).async {
//            Service.shared.fetchGenericData(urlString:
//            "http://v1.khargny.com/api/category/places?lang=ar&category_id=\(id)&page=\((self.currentPage))") { (data:CategoryExplore) in
//                if data.statusCode == 200{
//                    self.delegate?.sendData(data.places.data)
//                    if self.currentPage >= data.places.lastPage{
//                        self.delegate?.newFeedLoading(false)
//                    }
//                }
//                
//                
//            }
//            
//            
//        }
//    }
//    
//    
//    func loadMoreFeed(scrollView:UIScrollView,offsetY:CGFloat,contentHeight:CGFloat,categoryID:Int) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        if offsetY > contentHeight - scrollView.frame.height{
//            self.currentPage += 1
//            fetchData(id: categoryID)
//        }
//        
//  }
    
}
