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
    var storedOffsets = [Int: CGFloat]()
    
    var searchResult=[SearchDataModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var BeginSearch:String?{
        didSet{
            searchResult.removeAll()
            if let searchTarget = self.BeginSearch{
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    DispatchQueue.main.async {
                        Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/search?lang=ar&name=\(searchTarget)") { (info:SearchInformation) in
                            if info.statusCode == 200{
                                print("move to explore using search bar ")
                                for searchResult in info.places.data{
                                    let newSearchResultObj = SearchDataModel(id: searchResult.id!, name: searchResult.name, rateAvg:Int(searchResult.rateAvg), numOfRater: searchResult.numOfRater, latitude: searchResult.latitude, longitude: searchResult.longitude, shortDesc: searchResult.shortDesc, address: searchResult.address, imageurl: searchResult.imageurl, isbookmarked: searchResult.isbookmarked, dashboardurl: searchResult.dashboardurl, images: searchResult.images)
                                    self?.searchResult.append(newSearchResultObj)
                                }
                                self?.collectionView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        collectionView.delegate=self
        collectionView.dataSource=self
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height-50)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 15.0)
        collectionView.collectionViewLayout = flowLayout
    }
    
    
    
    @IBAction func searchBarButton(_ sender: Any) {
        present(Helper.searchBarCustomization(searchController: searchController), animated: true, completion: nil)
    }
    
    
    
}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        cell.searchResults = searchResult[indexPath.row]
        cell.numberOfImages = searchResult[indexPath.row].images
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let collectionCell = cell as? HomeCollectionViewCell else { return }
        storedOffsets[indexPath.row] = collectionCell.collectionViewOffset
    }
    
}


extension HomeViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        BeginSearch = searchBar.text
        
    }
    
}
