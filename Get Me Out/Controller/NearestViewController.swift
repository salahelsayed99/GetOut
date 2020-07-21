//
//  NearestViewController.swift
//  Get Me Out
//
//  Created by Salah  on 21/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class NearestViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var places = [DatumE]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.fetchGenericData(urlString:             "http://v1.khargny.com/api/category/places?lang=ar&category_id=3") { (data:CategoryExplore) in
            self.places = data.places.data
            self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    
}



extension NearestViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
        
    }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! NearestCollectionViewCell
          
        cell.data = places[indexPath.row]
          
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          //performSegue(withIdentifier: "fromExploreToDescription", sender: self)
      }
    
    
}
