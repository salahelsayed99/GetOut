//
//  RatingViewController.swift
//  Get Me Out
//
//  Created by Salah  on 30/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos
import UnderLineTextField


class RatingViewController: UIViewController,UnderLineTextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var rate: CosmosView!{
        didSet{
            self.rate.rating = 0
        }
    }
    
    
    @IBOutlet weak var budgetTextField: UnderLineTextField!
    @IBOutlet weak var numberOfPeople: UnderLineTextField!
    @IBOutlet weak var eventDetailTextField: UnderLineTextField!
    
    @IBOutlet var textFieldCollection: [UnderLineTextField]!{
        didSet{
            for textField in self.textFieldCollection{
                textField.delegate = self
            }
        }
    }
    
    
    
    @IBOutlet weak var submitRate: UIButton!{
        didSet{
            submitRate.rounded()
        }
    }
    
    
    @IBAction func submitRate(_ sender: UIButton) {
        
    }
    
    
}
