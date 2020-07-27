//
//  CategoryViewController.swift
//  Get Me Out
//
//  Created by Salah  on 10/06/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    var categoryViewModel = CategoryViewModelController()
    var categories = [CategoryViewModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewModel.delegate=self
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData()
    }
    
    
    func fetchData(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.categoryViewModel.fetchData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        guard let tabBar = tabBarController?.tabBar else { fatalError("TabBar controller does not exist.")
        }
        navBar.firstViewAfterTabBar()
        navigationItem.largeTitleDisplayMode = .automatic
        tabBar.firstViewAfterTabBar()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        navBar.secondaryViewController()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ExploreViewController
        if let indexpath = collectionView.indexPathsForSelectedItems{
            let stringCatID = categories[indexpath[0].row].id
            destinationVC.data = stringCatID
            destinationVC.name = categories[indexpath[0].row].name
            
        }
        
    }
    
}


extension CategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tasnefatCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.data = categories[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToType", sender: self)
        
    }
    
    
    //MARK:-Collection view flow layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bound = collectionView.bounds
        let height = self.view.frame.height
        let width = self.view.frame.width
        let cellSize = (height < width) ? bound.height/2 : bound.width/2
        return CGSize(width: cellSize - 5.5 , height: cellSize - 5.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}


extension CategoryViewController:CategoryViewModelControllerDelegate{
    func sendCategory(_ data: [CategoryViewModel]) {
        categories=data
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
}
