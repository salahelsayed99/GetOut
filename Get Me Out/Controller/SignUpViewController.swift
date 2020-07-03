//
//  SignUpViewController.swift
//  Get Me Out
//
//  Created by Salah  on 27/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import UnderLineTextField

class SignUpViewController: UIViewController,UnderLineTextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    //MARK:- UIPickerView Stuff
    var citiesArray = [City]()
    
    var cityID:Int? = nil
    
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
    
    //MARK:-toolbar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        currentLocationTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissPickerView(){
        view.endEditing(true)
    }
    
    @IBOutlet weak var createButton: UIButton!{
        didSet{
            self.createButton.rounded()
        }
    }
    
    //MARK:-create url
    func checkData(){
        guard let fullName = nameTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let location = currentLocationTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if fullName.isEmpty || phone.isEmpty || email.isEmpty || location.isEmpty || password.isEmpty{
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alert = AlertService.showAlert(style: .alert, title: "Please fill all fields", message: nil, actions: [alertAction], completion: nil)
            present(alert, animated: true, completion: nil)
        }
        else{
            guard let id = cityID else {
                fatalError()
            }
            Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/signup?full_name=\(fullName)&email=\(email)&mobile=\(phone)&city_id=\(id)&password=\(password)") { (data:Signup) in
                if data.statusCode == 200{
                self.present(Helper.goToTabBar(), animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        citiesPicker.delegate = self
        currentLocationTextField.inputView = citiesPicker
        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/cities") { (citiesData:Cityes) in
            if citiesData.statusCode == 200{
                self.citiesArray = citiesData.cities
            }
            
        }
        createToolBar()
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
        checkData()
    }
}

