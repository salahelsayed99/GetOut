//
//  TextField+extensions.swift
//  Get Me Out
//
//  Created by Salah  on 27/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

extension UITextField{
    func setBottomBorder(){
        self.borderStyle = .none
        self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

}
