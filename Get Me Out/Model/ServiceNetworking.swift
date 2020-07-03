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






