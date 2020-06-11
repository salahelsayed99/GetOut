//
//  ExplainTableViewController.swift
//  Get Me Out
//
//  Created by Salah  on 30/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class ExplainTableViewController: UITableViewController{
    var categories = [CategoryHomeObject]()
    var storedOffsets = [Int: CGFloat]()


    var textIntoSearchBar:String?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var id:Int?
    var name:String?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var searchBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        searchController.searchBar.delegate = self
        super.viewDidLoad()
        tableView.separatorStyle = .none
        fetchData()
    }
    
    
    func fetchData(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            DispatchQueue.main.async {
                Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/home_categories?lang=ar") { (info:Category) in
                    if info.statusCode == 200{
                        for category in info.categories{
                            let newCategory = CategoryHomeObject(id: category.id, seeMoreAPIURL: category.seeMoreAPIURL, image: category.image, name: category.name, shortDesc: category.shortDesc, imageurl: category.imageurl, places: category.places)
                            self?.categories.append(newCategory)
                        }
                        self?.tableView.reloadData()
                    }
                }
                
            }
        }
    }
    
    
    //MARK:-Navigation and Tabbar controller
    
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
    
    //MARK:- searchBar
    
    @IBAction func searchBar(_ sender: UIBarButtonItem) {
        present(Helper.searchBarCustomization(searchController: searchController), animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExplainTableViewCell
        cell.places = categories[indexPath.row]
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0

        cell.buttonDelegate = self
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         guard let tableViewCell = cell as? ExplainTableViewCell else { return }
               storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToExplore"{
            if let destinationVc = segue.destination as? ExploreViewController{
                if let data = self.id{
                    destinationVc.data = data
                    destinationVc.name = name
                }
            }
            
        }
        if segue.identifier == "goToSearch"{
            if let dVC = segue.destination as? HomeViewController{
                dVC.BeginSearch = textIntoSearchBar
                searchController.isActive = false
            }
            
        }
    }
}


extension ExplainTableViewController:ButtonHandler{
    func getId(id: Int, title: String) {
        self.id = id
        self.name = title
        performSegue(withIdentifier: "goToExplore", sender: self)
    }
}



extension ExplainTableViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textIntoSearchBar = searchBar.text
        performSegue(withIdentifier: "goToSearch", sender: self)
      
    }
    
}



//MARK:-Animation
//    func animateTable() {
//              tableView.reloadData()
//              let cells = tableView.visibleCells
//
//              let tableViewHeight = tableView.bounds.size.height
//
//              for cell in cells {
//                  cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
//              }
//
//              var delayCounter = 0
//              for cell in cells {
//                  UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                      cell.transform = CGAffineTransform.identity
//                  }, completion: nil)
//                  delayCounter += 1
//              }
//          }
