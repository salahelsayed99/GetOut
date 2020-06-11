//
//  CategoryCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 30/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos

class ExploreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rate: CosmosView!
    
 
    
    var data:DatumEObject?{
           didSet{didupdate()}
       }
    
    func didupdate(){
        if  let url = URL(string: self.data!.imageurl ){
                    if let imageData = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                 self.categoryImage.image = UIImage(data: imageData)
                    self.name.text = self.data?.name
                    self.rate.rating = self.data?.rateAvg ?? 0
                 }
            }
        }
        contentView.backgroundColor = .white
        self.addShadow()
        
    }
    
}
