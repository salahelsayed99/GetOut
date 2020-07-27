//
//  SignUpViewController.swift
//  Get Me Out
//
//  Created by Salah  on 27/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import UnderLineTextField

class SignUpViewController: UIViewController,UnderLineTextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,SignUpViewModelDelegate{
    func permisionToContinue(_ per: Bool) {
        permission = per
    }
    
    
    var signUpViewModel = SignUpViewModelController()
    
    
    
    func passCities(_ data: [City]) {
        citiesArray = data
    }
    
 
   
  
    
    //MARK:- UIPickerView Stuff
    var citiesArray = [City]()
    var cityID:Int? = nil
    var permission = false
    let citiesPicker = UIPickerView()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityID = citiesArray[row].id
        currentLocationTextField.text = citiesArray[row].name
    }
    

  
    
    @IBOutlet weak var createButton: UIButton!{
        didSet{
            self.createButton.rounded()
        }
    }
    
    //MARK:-create url
    func checkValidation(){
        guard let fullName = nameTextField.text,let phone = phoneTextField.text,let email = emailTextField.text,let location = currentLocationTextField.text,let password = passwordTextField.text else { return }
        
        if !signUpViewModel.checkFillFields(fullName: fullName, location: location, password: password, phone: phone, email: email){
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alert = AlertService.showAlert(style: .alert, title: "Please fill all fields", message: nil, actions: [alertAction], completion: nil)
            present(alert, animated: true, completion: nil)
        }
        else{
            if let id = cityID  {
                signUpViewModel.createUrl(fullName: fullName, email: email, phone: phone, cityID: id, password: password)
                if permission{
                      present(Helper.goToTabBar(), animated: true, completion: nil)

                }else{
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    let alert = AlertService.showAlert(style: .alert, title: "Something Went wrong try again", message: nil, actions: [alertAction], completion: nil)
                    present(alert, animated: true, completion: nil)
                    
                }
            
        }
    }
    }
    override func viewDidLoad() {
        signUpViewModel.delegate = self
        citiesPicker.delegate = self
        signUpViewModel.getCityID()
        currentLocationTextField.inputView = citiesPicker
    }
    
    @IBOutlet weak var nameTextField:UnderLineTextField!{
        didSet{
            self.nameTextField.validationType = .afterEdit
            self.nameTextField.delegate = self
            
        }
    }
    
    @IBOutlet weak var phoneTextField: UnderLineTextField!{
        didSet{
            self.phoneTextField.validationType = .afterEdit
            self.phoneTextField.delegate = self
        }
    }
    @IBOutlet weak var emailTextField: UnderLineTextField!{
        didSet{
            self.emailTextField.validationType = .always
            self.emailTextField.delegate = self
        }
    }
    @IBOutlet weak var currentLocationTextField: UnderLineTextField!{
        didSet{
            self.currentLocationTextField.validationType = .afterEdit
            self.currentLocationTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UnderLineTextField!{
        didSet{
            self.passwordTextField.validationType = .always
            self.passwordTextField.delegate = self
        }
    }
    
    func textFieldValidate(underLineTextField: UnderLineTextField) throws{
        if underLineTextField.text?.count == 0{
            throw UnderLineTextFieldErrors
                .error(message: "please fill the field")
        }
        switch underLineTextField {
        case passwordTextField:
            throw UnderLineTextFieldErrors
                .warning(message: "The password must be from 7 to 17 character")
        case emailTextField:
            throw UnderLineTextFieldErrors
                .warning(message: "email should contain @ and .com")
        default:
            return
        }
    }
    
    @IBAction func createAcoount(_ sender: UIButton) {
        checkValidation()
    }
}



  
    

