//
//  ExplainTableViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 30/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit


protocol ButtonHandler {
    func getId(id:Int,title:String)
    func passPlaceId(placeId:Int)
}


class ExplainTableViewCell: UITableViewCell {
    
    var buttonDelegate:ButtonHandler?
    
    
    
    var places:ExplainViewModel?{
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
        if (places?.id) != nil{
            buttonDelegate?.getId(id:places!.id, title: places!.name)
        }
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
    
    

}


extension ExplainTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places?.places.data.count ?? 0
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! ExplainCollectionViewCell
        cell.data = places?.places.data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:170, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = places?.places.data[indexPath.row].id
        buttonDelegate?.passPlaceId(placeId: id!)
        print(id!)
    }
    
    

}
