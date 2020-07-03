//
//  DescriptionCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 13/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePlace: UIImageView!
    
    
//    var images:[ImageElement]?{
//        didSet{
//            for image in images!{
//                print("IMAGE IS "+image.imageurl)
//                if  let url = URL(string: image.imageurl ){
//                    if let imageData = try? Data(contentsOf: url){
//
//                        self.imagePlace.image = UIImage(data: imageData)
//
//                    }
//                }
//
//            }
//        }
//    }
    
    var image : ImageElement?{
        didSet{
            if  let url = URL(string: image!.imageurl ){
                                if let imageData = try? Data(contentsOf: url){
                                    self.imagePlace.image = UIImage(data: imageData)
            
                                }
                            }
            
        }
        
    }
    
    
    
}
