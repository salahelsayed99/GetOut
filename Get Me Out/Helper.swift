//
//  Helper.swift
//  Get Me Out
//
//  Created by Salah  on 04/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit


class Helper{
    
    
    var currentIndex = 0


    
    
    static func goToTabBar()->UIViewController{
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as!UITabBarController
        nextViewController.modalPresentationStyle = .fullScreen
        return nextViewController
    }
    
    
    static func searchBarCustomization(searchController:UISearchController)->UISearchController{
        searchController.hidesNavigationBarDuringPresentation = true
               searchController.searchBar.tintColor = UIColor.white
               searchController.searchBar.barTintColor = UIColor.link
               let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
               textFieldInsideSearchBar?.textColor = .black
               textFieldInsideSearchBar?.backgroundColor = .white
        return searchController
    }
    
    
    
   @objc  func slideImageDelegate(collectionView:UICollectionView,numberOfImages:Int){
        let desiredScrollPosition = (currentIndex < numberOfImages - 1) ? currentIndex+1 : 0
              collectionView.scrollToItem(at:IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
}


