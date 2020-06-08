//
//  SignUpViewController.swift
//  Get Me Out
//
//  Created by Salah  on 27/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import UnderLineTextField

class SignUpViewController: UIViewController,UnderLineTextFieldDelegate {
    let service = Service()
    @IBOutlet weak var createButton: UIButton!{
        didSet{
            self.createButton.rounded()
        }
    }
    
    
    override func viewDidLoad() {
    
    }
    
    @IBOutlet weak var nameTextField:UnderLineTextField!{
        didSet{
           // self.nameTextField.setBottomBorder()
            self.nameTextField.validationType = .afterEdit
            self.nameTextField.delegate = self

        }
    }
    
    @IBOutlet weak var phoneTextField: UnderLineTextField!{
        didSet{
            //self.phoneTextField.setBottomBorder()
            self.phoneTextField.validationType = .afterEdit
            self.nameTextField.delegate = self
        }
    }
    @IBOutlet weak var emailTextField: UnderLineTextField!{
        didSet{
            //self.emailTextField.setBottomBorder()
            self.emailTextField.validationType = .afterEdit
            self.emailTextField.delegate = self
        }
    }
    @IBOutlet weak var currentLocationTextField: UnderLineTextField!{
        didSet{
            //self.currentLocationTextField.setBottomBorder()
            self.currentLocationTextField.validationType = .afterEdit
            self.currentLocationTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UnderLineTextField!{
        didSet{
            //self.passwordTextField.setBottomBorder()
            self.passwordTextField.validationType = .afterEdit
            self.passwordTextField.delegate = self
        }
    }
    
       func textFieldValidate(underLineTextField: UnderLineTextField) throws{
        if underLineTextField.text?.count == 0{
            throw UnderLineTextFieldErrors

            .error(message: "Please fill the field")
            
        }
        switch underLineTextField {
        case passwordTextField:
            throw UnderLineTextFieldErrors

            .warning(message: "The password must be from 7 to 17 character")
        default:
            return
        }
    }

    @IBAction func createAcoount(_ sender: UIButton) {
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
        
        service.fetchSignUpData(email: email, password: password, fullName: fullName, mobile: phone, cityID: "1") { (info) in
            if info.statusCode == 200{
                print("success")
                self.present(Helper.goToTabBar(), animated: true, completion: nil)
            }
        }
    }
}

}


