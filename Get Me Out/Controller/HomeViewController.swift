//
//  HomeViewController.swift
//  Get Me Out
//
//  Created by Salah  on 24/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    
    var searchViewModel = SearchViewModelController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var storedOffsets = [Int: CGFloat]()
    var searchResult=[SearchViewModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var BeginSearch:String?{
        didSet{
            searchResult.removeAll()
            if let searchTarget = self.BeginSearch{
            searchViewModel.fetchData(searchTarget: searchTarget)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchViewModel.delegate=self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        collectionView.delegate=self
        collectionView.dataSource=self
        setCourselEffect()
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
       // cell.numberOfImages = searchResult[indexPath.row].images
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let collectionCell = cell as? HomeCollectionViewCell else { return }
        storedOffsets[indexPath.row] = collectionCell.collectionViewOffset
    }
    
    func setCourselEffect(){
        let flowLayout = UPCarouselFlowLayout()
               flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height-50)
               flowLayout.scrollDirection = .horizontal
               flowLayout.sideItemScale = 0.8
               flowLayout.sideItemAlpha = 1.0
               flowLayout.spacingMode = .fixed(spacing: 15.0)
               collectionView.collectionViewLayout = flowLayout
    }
    
}


extension HomeViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        BeginSearch = searchBar.text
    }
    
}


extension HomeViewController:SearchViewModelControllerDelegate{
    func sendSearchResults(_ data: [SearchViewModel]) {
        searchResult = data
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
}
