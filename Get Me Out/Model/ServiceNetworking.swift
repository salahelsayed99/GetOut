//
//  ServiceNetworking.swift
//  Get Me Out
//
//  Created by Salah  on 01/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation



    
    struct Service {
        static let shared = Service()
        
        
        func fetchSignUpData(email:String,password:String,fullName:String,mobile:String,cityID:String,completion: @escaping (Signup) -> ()) {
                          let urlString1 = "http://v1.khargny.com/api/signup?full_name=\(fullName)&email=\(email)&mobile=\(mobile)&city_id=\(cityID)&password=\(password)"
                          guard let url = URL(string: urlString1) else { return }
                          URLSession.shared.dataTask(with: url) { (data, _, err) in
                              if let err = err {
                                  print("Failed to fetch data:", err)
                                  return
                              }
                              guard let data = data else { return }
                              do {
                                  let info = try JSONDecoder().decode(Signup.self, from: data)
                                  DispatchQueue.main.async {
                                      completion(info)
                                  }
                              } catch let jsonErr {
                                  print("Failed to serialize json:", jsonErr)
                                  
                              }
                              
                          }.resume()
                      }
        
        func fetchSignInData(email:String,password:String,completion: @escaping (SignIn) -> ()) {
                   let urlString1 = "http://v1.khargny.com/api/signin?email=\(email)&password=\(password)"
            
                   guard let url = URL(string: urlString1) else { return }
                
                   URLSession.shared.dataTask(with: url) { (data, _, err) in
                       if let err = err {
                           print("Failed to fetch data:", err)
                           return
                       }
                       guard let data = data else { return }
                       do {
                           let info = try JSONDecoder().decode(SignIn.self, from: data)
                           DispatchQueue.main.async {
                               completion(info)
                           }
                       } catch let jsonErr {
                           print("Failed to serialize json:", jsonErr)
                       }
                       
                   }.resume()
               }
        
        func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, _, err) in
                if let err = err {
                    print("Failed to fetch home feed:", err)
                    return
                }
                
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                } catch let jsonErr {
                    print("Failed to serialize json:", jsonErr)
                }
                
                }.resume()
        }
        
        
    }
    
    
    
    


