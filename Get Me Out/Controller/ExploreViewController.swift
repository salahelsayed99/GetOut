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
    var recievedData=[ExploreViewModel]()
    var name:String?
    var exploreViewModel = ExploreViewModelController()
    var newFeedLoading = true

    
    override func awakeFromNib() {
        super.awakeFromNib()
        exploreViewModel.delegate = self
    }
    
        
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
                DispatchQueue.global(qos: .userInteractive).async {
                    self.exploreViewModel.fetchData(id: data)
                }
              }
          }
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "LoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCell")
        collectionView.delegate=self
        collectionView.dataSource=self
    }
    
}

extension ExploreViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return recievedData.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCollectionViewCell
                 cell.data = recievedData[indexPath.row]
                 return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as! LoadingCollectionViewCell
            if newFeedLoading{
                cell.activityIndicator.startAnimating()

            }else{
                cell.activityIndicator.isHidden = true
            }
            return cell
        }
     
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            let width = (view.frame.size.width - 20) / 2
            return CGSize(width: width, height: width - 30)
        }else{
            return CGSize(width: collectionView.bounds.size.width-30,  height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if let id = data{
        

                self.exploreViewModel.loadMoreFeed(scrollView: scrollView, offsetY: offsetY, contentHeight: contentHeight, categoryID: id)
            
        }
    }
}


extension ExploreViewController:ExploreViewModelControllerDelegate{
    func sendData(_ data: [ExploreViewModel]) {
        self.recievedData += data
        DispatchQueue.main.async {
                   self.collectionView.reloadData()
               }
    }
    
    func newFeedLoading(_ newFeed: Bool) {
        newFeedLoading = newFeed
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
    
 
}
