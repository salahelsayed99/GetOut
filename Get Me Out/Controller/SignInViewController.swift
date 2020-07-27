//
//  SignInViewController.swift
//  Get Me Out
//
//  Created by Salah  on 27/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class SignInViewController: UIViewController,UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //startAnimation()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
//        if userDefault.value(forKey: "userToken") != nil{
//            present(Helper.goToTabBar(), animated: true, completion: nil)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
        navBar.hide()
    }
    
    
    @IBOutlet weak var lottieView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInBtn(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if email.isEmpty || password.isEmpty{
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            let alert = AlertService.showAlert(style: .alert, title: "Please fill all fields", message: nil, actions: [alertAction], completion: nil)
            present(alert, animated: true, completion: nil)
        }
            
        else{
            SignInViewModelController.shared.createUrl(email: email, password: password)
             self.present(Helper.goToTabBar(), animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    @IBAction func signInFaceBook(_ sender: UIButton) {
    }
    @IBAction func goToSignUp(_ sender: UIButton) {
    }
    @IBOutlet weak var faceBookButton: UIButton!{
        didSet{
            self.faceBookButton.rounded()
        }
    }
    
    
    
}







