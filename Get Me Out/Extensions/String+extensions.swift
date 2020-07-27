//
//  String+extensions.swift
//  Get Me Out
//
//  Created by Salah  on 01/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation


extension String{
    
    var trimmed:String{
       return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
        var isInt: Bool {
            return Int(self) != nil
        }
    
    }

