//
//  ExplainCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 30/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos

class ExplainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imagePlace: UIImageView!
    
    @IBOutlet weak var namePlace: UILabel!{
        didSet{
            self.namePlace.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var ratePlace: CosmosView!
    
    
    var data:Datum?{
        didSet{
            setData()
        }
    }
    
    @objc func setData(){
                let url = URL(string:data!.imageurl )
                imagePlace.kf.setImage(with: url)
                self.namePlace.text = self.data?.name
                self.ratePlace.rating = self.data?.rateAvg ?? 0
            
        self.addShadow()
}

    
    
}
