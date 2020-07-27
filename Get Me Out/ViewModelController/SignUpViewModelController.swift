//
//  SignUpViewModel.swift
//  Get Me Out
//
//  Created by Salah  on 22/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

protocol SignUpViewModelDelegate{
    func passCities(_ data:[City])
    func permisionToContinue(_ per:Bool)
}


struct SignUpViewModelController{
    
    var delegate:SignUpViewModelDelegate?
    
    
    func createUrl(fullName:String,email:String,phone:String,cityID:Int,password:String){
        DispatchQueue.global(qos: .userInitiated).async {
            Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/signup?full_name=\(fullName)&email=\(email)&mobile=\(phone)&city_id=\(cityID)&password=\(password)") { (data:Signup) in
                 if data.statusCode == 200{
                    self.delegate?.permisionToContinue(true)
                 }
             }
        }
    }
    
    
    
    
    func getCityID(){
        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/cities") { (citiesData:Cityes) in
            if citiesData.statusCode == 200{
                let data = citiesData.cities
                self.delegate?.passCities(data)
            }
        }
    }
    
    
    func checkFillFields(fullName:String,location:String,password:String,phone:String,email:String)->Bool{
               if fullName.isEmpty || phone.isEmpty || email.isEmpty || location.isEmpty || password.isEmpty{
                    return false
               }
               else{
                return true
        }
    }
}
