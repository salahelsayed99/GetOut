//
//  File.swift
//  Get Me Out
//
//  Created by Salah  on 09/04/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class AlertService {
    
    static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
    return alert
    }
}

