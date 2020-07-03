//
//  NavigationController+extension.swift
//  Get Me Out
//
//  Created by Salah  on 31/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

extension UINavigationBar{
    func hide(){
        self.isHidden = true
    }
    
    func firstViewAfterTabBar(){
        self.prefersLargeTitles = true
        self.sizeToFit()
    }
    
    func secondaryViewController(){
        self.prefersLargeTitles = false
        self.tintColor = .white
        self.barTintColor = .blue
    }
}

