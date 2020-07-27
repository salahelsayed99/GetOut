//
//  SignInViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 22/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation


class SignInViewModelController{
    static let shared = SignInViewModelController()
    
    let userDefault = UserDefaults.standard
    
    
    func createUrl(email:String,password:String){
        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/signin?email=\(email)&password=\(password)") { (obj:SignIn) in
            if obj.statusCode == 200{
                print("sucess")
                self.userDefault.set(obj.user.token.userID, forKey: "userToken")
            }
        }
    }
    
    
    
}
