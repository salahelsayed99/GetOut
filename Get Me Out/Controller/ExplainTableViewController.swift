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
    
    var textIntoSearchBar:String?{
        didSet{
            //print(self.textIntoSearchBar)
        }
    }
    
    
    var id:Int?
    var name:String?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var searchBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        searchController.searchBar.delegate = self
        super.viewDidLoad()
        tableView.separatorStyle = .none
              Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/home_categories?lang=ar") { (info:Category) in
                      if info.statusCode == 200{
                        for category in info.categories{
                            let newCategory = CategoryHomeObject(id: category.id, seeMoreAPIURL: category.seeMoreAPIURL, image: category.image, name: category.name, shortDesc: category.shortDesc, imageurl: category.imageurl, places: category.places)
                            self.categories.append(newCategory)
                        }
                         self.tableView.reloadData()
                      }
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
    
    //MARK:- searchBar
    
    @IBAction func searchBar(_ sender: UIBarButtonItem) {
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.blue
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
        textFieldInsideSearchBar?.backgroundColor = .white
        present(searchController, animated: true, completion: nil)
    }
    
    
    
    
    
  // MARK: - Table view data source

    
    
    
        
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExplainTableViewCell
        //cell.categoryName.text = self.categories[indexPath.row].name
        cell.places = categories[indexPath.row]
        cell.buttonDelegate = self
        return cell
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? HomeViewController{
            if let data = self.id{
                destinationVc.data = data
                destinationVc.name = name
                
            }
            destinationVc.BeginSearch = textIntoSearchBar
            //print(textIntoSearchBar)
        }
    }
}


extension ExplainTableViewController:CollectionViewCellDelegate,ButtonHandler{
    func getId(id: Int, title: String) {
        self.id = id
        self.name = title
        performSegue(withIdentifier: "goToExplore", sender: self)

    }
    
    func getId(id: Int) {
        self.id = id
        
        print(id)
    }
    
    func collectionView(collectioncell: ExplainCollectionViewCell?, index: Int, didTappedInTableview TableCell: ExplainTableViewCell) {
        
      //send to description ViewController
    }
    
    
}

    
    
extension ExplainTableViewController:UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textIntoSearchBar = searchBar.text
       // print(textIntoSearchBar)
        performSegue(withIdentifier: "goToExplore", sender: self)
//        if let searchTarget = searchBar.text{
//                               DispatchQueue.main.async {
//                                   Service.shared.fetchGenericData(urlString: "http://v1.khargny.com/api/search?lang=ar&name=\(searchTarget)") { (info:SearchInformation) in
//                                       if info.statusCode == 200{
//                                        print("move to explore using search bar ")}}
//    }
//        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let vc = UIViewController() as? ExplainTableViewController{
        present(vc, animated: true, completion: nil)
        
        searchBar.resignFirstResponder()
        }
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
