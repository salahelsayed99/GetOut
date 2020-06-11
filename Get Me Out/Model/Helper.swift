//
//  Helper.swift
//  Get Me Out
//
//  Created by Salah  on 04/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit


struct Helper{
    
    let window:UIWindow?
    
    
    static func saveToken(token:Int){
        let userDefault = UserDefaults.standard
        userDefault.set(token, forKey: "userToken")
    }
    
    static func fetchToken()->Int?{
        let userDefault = UserDefaults.standard
        return userDefault.object(forKey: "userToken") as? Int
    }
    
    
    static func goToTabBar()->UIViewController{
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as!UITabBarController
        nextViewController.modalPresentationStyle = .fullScreen
        return nextViewController
    }
    
    
    static func searchBarCustomization(searchController:UISearchController)->UISearchController{
        searchController.hidesNavigationBarDuringPresentation = true
               searchController.searchBar.tintColor = UIColor.white
               searchController.searchBar.barTintColor = UIColor.blue
               let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
               textFieldInsideSearchBar?.textColor = .black
               textFieldInsideSearchBar?.backgroundColor = .white
        return searchController
    }
    
}


