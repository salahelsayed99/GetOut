//
//  CategoryCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 10/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!{
        didSet{
             self.cellLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    
}