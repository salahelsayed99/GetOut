//
//  ExplainTableViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 30/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
     func collectionView(collectioncell:ExplainCollectionViewCell?,index: Int,didTappedInTableview TableCell:ExplainTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

protocol ButtonHandler {
    func getId(id:Int,title:String)
}


class ExplainTableViewCell: UITableViewCell {
    
//var didSelectItemAction: ((Places) -> Void)?
    var cellDelegate:CollectionViewCellDelegate?
    var buttonDelegate:ButtonHandler?
    var places:CategoryHomeObject?{
        didSet{
            categoryName.text = self.places?.name
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var categoryName: UILabel!{
        didSet{
            self.categoryName.adjustsFontSizeToFitWidth = true

        }
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func exploreMore(_ sender: UIButton) {
        //nextViewController.data = places?.id (CategoryElement)
        if (places?.id) != nil{
            //print(places?.id)
            buttonDelegate?.getId(id:places!.id, title: places!.name)
        }
    }
}


extension ExplainTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{




 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places?.places.data.count ?? 0
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! ExplainCollectionViewCell
        cell.data = places?.places.data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:190, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ExplainCollectionViewCell
               print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.collectionView(collectioncell: cell, index: indexPath.item, didTappedInTableview: self)
    }
}
