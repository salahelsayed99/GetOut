//
//  ExploreViewModelController.swift
//  Get Me Out
//
//  Created by Salah  on 26/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit


protocol ExploreViewModelControllerDelegate {
    func sendData(_ data:[ExploreViewModel])
    func newFeedLoading(_ newFeed:Bool)
}


class ExploreViewModelController{
    var exploreViewModelArray = [ExploreViewModel]()


    var currentPage:Int = 1
    var delegate:ExploreViewModelControllerDelegate?





     func fetchData(id:Int){
        DispatchQueue.global(qos: .userInteractive).async {
            Service.shared.fetchGenericData(urlString:
            "http://v1.khargny.com/api/category/places?lang=ar&category_id=\(id)&page=\(String(describing: (self.currentPage)))") { (data:CategoryExplore) in
                if data.statusCode == 200{
                    self.exploreViewModelArray = data.places.data.map({return ExploreViewModel(cell: $0)})
                    self.delegate?.sendData(self.exploreViewModelArray)
                    if self.currentPage >= data.places.lastPage{
                    self.delegate?.newFeedLoading(false)
                    }
                }
            }
        }
    }





    func loadMoreFeed(scrollView:UIScrollView,offsetY:CGFloat,contentHeight:CGFloat,categoryID:Int) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > (contentHeight - scrollView.frame.height)-400{
            self.currentPage += 1
            fetchData(id: categoryID)
        }

    }



}


//scrollView.frame.height
