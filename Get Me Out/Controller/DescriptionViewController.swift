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
    
    // let descriptionPlaceViewModel = DescriptionPlaceViewModel()
    var descriptionPlace:Place?{
        didSet{
            pageControl.numberOfPages = (descriptionPlace?.images.count)!
             setData()
        }
    }
    
    func setData(){
        placeDescription.text = descriptionPlace?.shortDesc
        numberOfRaters.text = String(descriptionPlace!.numOfRater)
        placeRateInDescription.rating = Double(descriptionPlace!.rateAvg)
        namePlace.text = descriptionPlace?.name
    }
    

    var recievedPlaceId:Int?{
        didSet{
            if let id = recievedPlaceId{
                //descriptionPlaceViewModel.fetchData(id)
                fetchData(id: id)
            }
        }
    }
    
    
    
    func fetchData(id:Int){
        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/place?lang=ar&place_id=\(id)") { (data:PlaceDescription) in
            if data.statusCode == 200{
                print("HERE IS FETCH")
                // self.passDataDelegate?.passData(data: data.place)
                self.descriptionPlace = data.place
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
        
    }
    
    var placeData:Place?{
        didSet{
            //collectionView.reloadData()
            //tableView.reloadData()
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
    
    var currentIndex = 0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        timer = Timer.scheduledTimer(timeInterval:  3.0, target: self, selector:#selector(changeImage), userInfo: nil, repeats: true)
    }
    
    @objc func changeImage(){
        let desiredScrollPosition = (currentIndex < (descriptionPlace?.images.count)! - 1) ? currentIndex+1 : 0
        collectionView.scrollToItem(at:IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
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
    
}


extension DescriptionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptionPlace?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("HERE IS CODE" )
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! DescriptionCollectionViewCell
        cell.image = descriptionPlace?.images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size=collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = currentIndex
    }
    
    
}

extension DescriptionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptionPlace?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentTableViewCell
        cell.comments = descriptionPlace?.rates[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


extension DescriptionViewController:passPlaceData{
    func passData(data: Place) {
        self.placeData = data
        placeDescription.text = data.shortDesc
    }
    
}
