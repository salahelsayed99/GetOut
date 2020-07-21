//
//  NearestCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 21/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos

class NearestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var rate: CosmosView!
    
    
    
    
    var data:DatumE?{
        didSet{
            didupdate()
        }
    }
    
    
    
    func didupdate(){
        if  let url = URL(string: self.data!.imageurl ){
                    if let imageData = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                 self.image.image = UIImage(data: imageData)
                    self.name.text = self.data?.name
                    self.rate.rating = self.data?.rateAvg ?? 0
                 }
            }
        }
        contentView.backgroundColor = .white
        self.addShadow()
        
    }
    

    
    
    
    
}
