//
//  slideImageCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 07/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class slideImageCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var bookmarkButton: UIButton!{
        didSet{
            self.bookmarkButton.circle()
        }
    }
    

    
    
    
    var setImages:[UIImage]?{
        didSet{
            for image in self.setImages!{
            images.image = image
            }
        }
    }
  
    
  
    
}
