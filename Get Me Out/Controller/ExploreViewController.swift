//
//  CategoryViewController.swift
//  Get Me Out
//
//  Created by Salah  on 30/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var rightArrow: UIBarButtonItem!
    @IBOutlet weak var leftArrow: UIBarButtonItem!{
        didSet{
            if currentPage == 1{
                     leftArrowDisabled()
                   }else{
                       leftArrowEnabled()
                   }
        }
    }
    var recievedData=[DatumEObject]()
    var name:String?
    var lastPage:Int?
    var currentPage:Int = 1
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            if let navtitle = self.name{
                title = navtitle
            }
            collectionView.reloadData()
        }
    
    var data:Int?{
          didSet{
              if let data = self.data{
                  fetchData(id: data)
              }
          }
      }
    
    func fetchData(id:Int){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        DispatchQueue.main.async {
            Service.shared.fetchGenericData(urlString:
            "http://v1.khargny.com/api/category/places?lang=ar&category_id=\(id)&page=\((self!.currentPage))") { (data:CategoryExplore) in
                if data.statusCode == 200{
                    self!.lastPage = data.places.lastPage
                    for data in data.places.data{
                        let newObj = DatumEObject(id: data.id!, name: data.name, rateAvg: data.rateAvg, numOfRater: data.numOfRater, latitude: data.latitude, longitude: data.longitude, shortDesc: data.shortDesc, address: data.address, imageurl: data.imageurl, isbookmarked: data.isbookmarked, dashboardurl: data.dashboardurl)
                        print(newObj.name)
                        self?.recievedData.append(newObj)
                    }
                    self?.collectionView.reloadData()

                }
                
            }
        }
    }
}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        let width = (view.frame.size.width - 20) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width - 30)
    }
    
    
    @IBAction func leftArrowAction(_ sender: UIBarButtonItem) {
        if currentPage == 1{
         leftArrowDisabled()
        }else{
            recievedData.removeAll()
                     currentPage -= 1
                     fetchData(id: data!)
                     RightArrowEnabled()
                     leftArrowEnabled()
        }
         
    }
    
    
    @IBAction func rightArrowAction(_ sender: Any) {
        if currentPage <= lastPage! - 1{
            recievedData.removeAll()
            currentPage += 1
            fetchData(id: data!)
            RightArrowEnabled()
            leftArrowEnabled()
        }
        else{
          RightArrowDisabled()
            
        }
        
    }
    
    
    func leftArrowEnabled(){
        leftArrow.isEnabled = true
        leftArrow.image = UIImage(systemName: "arrowtriangle.left.fill")
    }
    func leftArrowDisabled(){
        leftArrow.isEnabled = false
        leftArrow.image = UIImage(systemName: "arrowtriangle.left")
       }
    
    func RightArrowEnabled(){
        leftArrow.isEnabled = true
        leftArrow.image = UIImage(systemName: "arrowtriangle.right.fill")
    }
    func RightArrowDisabled(){
        rightArrow.isEnabled = false
        rightArrow.image = UIImage(systemName: "arrowtriangle.right")
       }
    
    
}

extension ExploreViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recievedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCollectionViewCell
        
        cell.data = recievedData[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromExploreToDescription", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromExploreToDescription"{
            if let dvc = segue.destination as? DescriptionViewController{
                 let indexpath = collectionView.indexPathsForSelectedItems
                if let selectedIndexPath = indexpath?.first{
                    dvc.recievedPlaceId = recievedData[selectedIndexPath.row].id
                }
        }
    }
}
}
extension ExploreViewController:UICollectionViewDelegateFlowLayout{

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
      }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
