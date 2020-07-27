//
//  CategoryCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 30/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class ExploreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rate: CosmosView!
    
 
    
    var data:ExploreViewModel?{
        
           didSet{didupdate()}
       }
    
    func didupdate(){
                    let url = URL(string: self.data!.imageurl)
                    categoryImage.kf.setImage(with: url)
                    self.name.text = self.data?.name
                    self.rate.rating = self.data?.rateAvg ?? 0
              
            
     
        contentView.backgroundColor = .white
        self.addShadow()
    }
    }
    

