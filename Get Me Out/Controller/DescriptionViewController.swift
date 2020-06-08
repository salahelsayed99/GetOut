//
//  DescriptionViewController.swift
//  Get Me Out
//
//  Created by Salah  on 13/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit
import Cosmos

class DescriptionViewController: UIViewController {
  
    
    
    var data:Datum?{
        didSet{
            print(self.data?.name ?? "error")
            setData()
        }
    }
    
    
    
    @IBOutlet weak var rateView: UIView!{
        didSet{
            self.rateView.rounded()
        }
    }
    
    @IBOutlet weak var placeDescription: UITextView!{
        didSet{
            self.placeDescription.isEditable = false
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var menuButton: UIButton!
        {
        didSet{
            self.menuButton.circle()
        }
    }
    @IBOutlet weak var locationButton: UIButton!{
        didSet{
            self.locationButton.circle()
        }
    }
    @IBOutlet weak var numberButton: UIButton!{
        didSet{
            self.numberButton.circle()
        }
    }
    @IBOutlet weak var favouriteButton: UIButton!{
        didSet{
            self.favouriteButton.circle()
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numberOfRaters: UILabel!
    @IBOutlet weak var placeRateInDescription: CosmosView!
    
    @IBOutlet weak var userRate: CosmosView!
    @IBOutlet weak var namePlace: UILabel!
    var timer=Timer()
    var counter=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages=7
        pageControl.currentPage=0
        timer=Timer.scheduledTimer(timeInterval: 2.0, target: self, selector:#selector(changeImage), userInfo: nil, repeats: true)
        tableView.register(UINib(nibName:"CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    @objc func changeImage(){
        if counter<7{
            let indexPath=IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage=counter
            counter=counter+1
            
        }
        else{
            counter=0
            let indexPath=IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            pageControl.currentPage=counter
            counter=1
        }
    }
    @IBAction func menuBtn(_ sender: Any) {
        //go to menu (undone) using collection view
    }
    
    @IBAction func mapBtn(_ sender: Any) {
        // go to map (done)
    }
    
    @IBAction func callBtn(_ sender: Any) {
        let numberInString = String(01020650948) //
        if let url = URL(string: "telprompt://\(numberInString)"){
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func addFavBtn(_ sender: Any) {
        // go to fav (undone)
    }
    
    func setData(){
        DispatchQueue.main.async {
            self.namePlace.text = self.data?.name
            self.placeRateInDescription.rating = self.data?.rateAvg ?? 0
            self.placeDescription.text = self.data?.shortDesc
            self.numberOfRaters.text = "\(String(describing: self.data?.numOfRater))"
        }
       
    }
    
}


extension DescriptionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DescriptionCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size=collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0.0
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0.0
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //    }
    
}

extension DescriptionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentTableViewCell
        cell.label.text="nice place"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
    
}
