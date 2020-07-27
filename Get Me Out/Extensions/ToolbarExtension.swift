//
//  ToolbarExtension.swift
//  Get Me Out
//
//  Created by Salah  on 23/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

extension UIToolbar {

    
    func setToolbar(){
        self.sizeToFit()
         self.isUserInteractionEnabled = true
//          let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        //self.setItems([doneButton], animated: false)
    }
 
    
    @objc func dismissPickerView(){
        self.endEditing(true)
       }

}
