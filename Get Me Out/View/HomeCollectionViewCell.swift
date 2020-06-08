//
//  ExploreCollectionViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 24/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos

class HomeCollectionViewCell:UICollectionViewCell{
   
    
    @IBOutlet weak var colllectionViewImages: UICollectionView!{
        didSet{
            self.colllectionViewImages.delegate = self
            self.colllectionViewImages.dataSource = self
        }
    }
    
    var arrrayOfImages = [UIImage]()
    
    var arraySearchResultImages = [UIImage]()
    
    
    @IBOutlet weak var viewContainingButtons: UIView!{
        didSet{
            self.viewContainingButtons.rounded()
        }
    }
    
    @IBOutlet var circleButtons: [UIButton]!{
        didSet{
            for button in self.circleButtons{
                button.circle()
            }
        }
    }
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var numberOfRaters: UILabel!
    
    @IBOutlet weak var placeRate: CosmosView!
    @IBOutlet weak var shortDesc: UITextView!{
        didSet{
            self.shortDesc.isEditable = false
        }
    }
    
    var data:DatumEObject?{
        didSet{
                
            
            if  let url = URL(string: self.data!.imageurl ){
                        if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.arrrayOfImages.append(UIImage(data: imageData)!)
                        self.placeName.text = self.data?.name
                        self.placeRate.rating = self.data?.rateAvg ?? 0
                        self.shortDesc.text = self.data?.shortDesc
                        self.numberOfRaters.text = String("\(self.data?.numOfRater ?? 0) peoples Rate this place")
                        self.colllectionViewImages.reloadData()
                    }
                }
            }
        }}
    
    
    var searchResults:SearchDataModel?{
        didSet{
            self.placeName.text = self.searchResults?.name
            self.placeRate.rating = Double(self.searchResults?.rateAvg ?? 3)
            self.shortDesc.text = self.searchResults?.shortDesc
            self.numberOfRaters.text = String("\(self.searchResults?.numOfRater ?? 0) peoples Rate this place")
            for setOfImage in self.searchResults!.images{
                if  let url = URL(string: setOfImage.imageurl ){
                    if let imageData = try? Data(contentsOf: url){
                        self.arraySearchResultImages.append(UIImage(data: imageData)!)
                    }
                }
            }
            self.colllectionViewImages.reloadData()
        }
    }
    
    
    
    @IBAction func createEvent(_ sender: UIButton) {
    }
    
    @IBAction func isBookmarked(_ sender: UIButton) {
    }
    
    @IBAction func menu(_ sender: UIButton) {
    }
    
    @IBAction func location(_ sender: UIButton) {
    }
    @IBAction func phone(_ sender: UIButton) {
    }
    
    @IBAction func anotherMenu(_ sender: UIButton) {
    }
    
    
}


extension HomeCollectionViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // print(arrrayOfImages.count)
        if arrrayOfImages.count != 0{
            return arrrayOfImages.count
        }
        else{
            return arraySearchResultImages.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colllectionViewImages.dequeueReusableCell(withReuseIdentifier: "slideImages", for: indexPath) as! slideImageCollectionViewCell
            
        if arrrayOfImages.count != 0{
                   cell.setImages = arrrayOfImages.remove(at: indexPath.row)
               }
               else{
            cell.setImages = arraySearchResultImages[indexPath.row]
               }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let size=collectionView.frame.size
           return CGSize(width: size.width, height: size.height)
       }
    
}
