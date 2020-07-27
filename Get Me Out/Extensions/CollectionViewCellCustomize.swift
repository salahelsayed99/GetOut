//
//  CollectionViewCellCustomize.swift
//  Get Me Out
//
//  Created by Salah  on 09/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit


extension UICollectionViewCell{
    
      
        func addShadow(){
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 0.5
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        }
    
    
        
}



