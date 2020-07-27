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
    
    override func awakeFromNib() {
        timer = Timer.scheduledTimer(timeInterval:  3.0, target: self, selector:#selector(changeImage), userInfo: nil, repeats: true)
        self.rounded()
    }
    
    
    var currentIndex = 0
    var timer:Timer?
    
    var numberOfImages:[Image]?{
        didSet{
            pageControllE.numberOfPages = self.numberOfImages!.count
        }
    }
    
    
    
    @IBOutlet weak var bookMArkButton: UIButton!{
        didSet{
            self.bookMArkButton.circle()
        }
    }
    
    @IBOutlet weak var pageControllE: UIPageControl!
    
    
    @IBOutlet weak var colllectionViewImages: UICollectionView!{
        didSet{
            self.colllectionViewImages.delegate = self
            self.colllectionViewImages.dataSource = self
        }
    }
    
    var arraySearchResultImages = [[UIImage]]()
    
    
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
    @IBOutlet weak var placeName: UILabel!{
        didSet{
            self.placeName.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var numberOfRaters: UILabel!
    
    @IBOutlet weak var placeRate: CosmosView!
    @IBOutlet weak var shortDesc: UITextView!{
        didSet{
            self.shortDesc.isEditable = false
        }
    }
    
    
    var searchResults:SearchViewModel?{
        didSet{
            DispatchQueue.main.async {
                self.placeName.text = self.searchResults?.name
                self.placeRate.rating = Double(self.searchResults?.rateAvg ?? 3)
                self.shortDesc.text = self.searchResults?.shortDesc
                self.numberOfRaters.text = String("\(self.searchResults?.numOfRater ?? 0) peoples Rate this place")
                self.pageControllE.numberOfPages = self.searchResults!.images.count
                self.numberOfImages = self.searchResults!.images
                self.colllectionViewImages.reloadData()
            }
            
        }
    }
    
    
    
    
    @objc func changeImage(){
        let desiredScrollPosition = (currentIndex < numberOfImages!.count - 1) ? currentIndex+1 : 0
        colllectionViewImages.scrollToItem(at:IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    @IBAction func createEvent(_ sender: UIButton) {
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
        return searchResults?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colllectionViewImages.dequeueReusableCell(withReuseIdentifier: "slideImages", for: indexPath) as! slideImageCollectionViewCell
        
        
        cell.setImages = searchResults?.images
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size=collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / colllectionViewImages.frame.size.width)
        pageControllE.currentPage = currentIndex
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    var collectionViewOffset: CGFloat {
        set { colllectionViewImages.contentOffset.x = newValue }
        get { return colllectionViewImages.contentOffset.x }
    }
    
}
