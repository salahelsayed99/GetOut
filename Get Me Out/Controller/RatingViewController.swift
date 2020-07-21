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


class RatingViewController: UIViewController,UnderLineTextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var vacationType = [DatumType]()
    
    let vacationTypePickerView = UIPickerView()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vacationType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vacationType[row].name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
        eventDetailTextField.text = vacationType[row].name
      }
    
    
    func createToolBar(){
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        eventDetailTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissPickerView(){
        view.endEditing(true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        vacationTypePickerView.delegate = self
        eventDetailTextField.inputView = vacationTypePickerView
        Service.shared.fetchGenericData(urlString: "https://v1.khargny.com/api/get_types") { (data:VacationType) in
            if data.code == 200{
                self.vacationType = data.data
                print(data.data[0].name)
            }
        }
        createToolBar()
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
    
    
    func checkUserRate(){
        
//        Service.shared.fetchGenericData(urlString: "https://v1.khargny.com/api/check_last_trip_status") { (<#Decodable#>) in
//            <#code#>
//        }
        
        
    }
    
}
