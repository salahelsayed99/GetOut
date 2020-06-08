//
//  HomeViewController.swift
//  Get Me Out
//
//  Created by Salah  on 24/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recievedData=[DatumEObject]()
    
    var searchResult=[SearchDataModel]()
    
    
    var name:String?
    
  
    
    var BeginSearch:String?{
        didSet{
            if let searchTarget = self.BeginSearch{
                DispatchQueue.main.async {
                    Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/search?lang=ar&name=\(searchTarget)") { (info:SearchInformation) in
                        if info.statusCode == 200{
                            print("move to explore using search bar ")
                            for searchResult in info.places.data{
                                let newSearchResultObj = SearchDataModel(id: searchResult.id!, name: searchResult.name, rateAvg:Int(searchResult.rateAvg), numOfRater: searchResult.numOfRater, latitude: searchResult.latitude, longitude: searchResult.longitude, shortDesc: searchResult.shortDesc, address: searchResult.address, imageurl: searchResult.imageurl, isbookmarked: searchResult.isbookmarked, dashboardurl: searchResult.dashboardurl, images: searchResult.images)
                                
                                print(newSearchResultObj.name)
                                
                                self.searchResult.append(newSearchResultObj)
                            }
                            self.collectionView.reloadData()

                        }
                        
                    }
                }
            }
        }
    }
    var data:Int?{
          didSet{
              if let data = self.data{
                  DispatchQueue.main.async {
                      Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/category/places?lang=ar&category_id=\(data)") { (data:CategoryExplore) in
                          if data.statusCode == 200{
                              print("move to explore successfully")
                              for data in data.places.data{
                                  let newObj = DatumEObject(id: data.id!, name: data.name, rateAvg: data.rateAvg, numOfRater: data.numOfRater, latitude: data.latitude, longitude: data.longitude, shortDesc: data.shortDesc, address: data.address, imageurl: data.imageurl, isbookmarked: data.isbookmarked, dashboardurl: data.dashboardurl)
                                  
                                  self.recievedData.append(newObj)
                              }
                              self.collectionView.reloadData()

                          }
                          
                      }
                  }
                  
              }
          }
      }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 15.0)
        collectionView.collectionViewLayout = flowLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //print(self.name)
        if let navtitle = self.name{
            title = navtitle
        }
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(recievedData?.count)
        if recievedData.count != 0{
            
            return recievedData.count
        }
        else  {
            return searchResult.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        if searchResult.count != 0{
            
            cell.searchResults = searchResult[indexPath.row]

        }
        else{
            cell.data = recievedData[indexPath.row]

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


