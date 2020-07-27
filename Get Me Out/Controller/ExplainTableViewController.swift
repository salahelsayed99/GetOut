//
//  ExplainTableViewController.swift
//  Get Me Out
//
//  Created by Salah  on 30/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class ExplainTableViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
   var explainViewModel = ExplainViewModelController()
    
    var categories = [ExplainViewModel]()
    var storedOffsets = [Int: CGFloat]()

    @IBOutlet var rateView: UIView!
    @IBOutlet var tableView: UITableView!
    var textIntoSearchBar:String?
    var categoryId:Int?
    var categoryName:String?
    var placeId:Int?{
        didSet{
            print("wasal")
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var searchBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setRateView()
        explainViewModel.delegate = self
        explainViewModel.fetchData()
        searchController.searchBar.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    

    
    
    //MARK:-RateView
    
    func setRateView(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        blurredEffectView.isHidden = false
        view.addSubview(blurredEffectView)
        //rateView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        rateView.center.x = self.view.center.x // for horizontal
        rateView.center.y = self.view.center.y // for vertical
        rateView.layer.cornerRadius = 8
        rateView.isHidden = false
        view.addSubview(rateView)
    }
    
    
    //MARK:-Navigation and Tabbar controller
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        guard let tabBar = tabBarController?.tabBar else { fatalError("TabBar controller does not exist.")
        }
        navBar.firstViewAfterTabBar()
        //navigationItem.largeTitleDisplayMode = .automatic
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
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExplainTableViewCell
        cell.places = categories[indexPath.row]
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        cell.buttonDelegate = self
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

           guard let tableViewCell = cell as? ExplainTableViewCell else { return }
           tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
       }

    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         guard let tableViewCell = cell as? ExplainTableViewCell else { return }
               storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToExplore"{
            if let destinationVc = segue.destination as? ExploreViewController{
                if let data = self.categoryId{
                    destinationVc.data = data
                    destinationVc.name = categoryName
                }
            }
            
        }
        if segue.identifier == "goToSearch"{
            if let dVC = segue.destination as? HomeViewController{
                dVC.BeginSearch = textIntoSearchBar
                searchController.isActive = false
            }
        }
        
        if segue.identifier == "goToDescription"{
            if let dvc = segue.destination as? DescriptionViewController{
                dvc.recievedPlaceId = placeId
            }
        }
    }
}


extension ExplainTableViewController:ButtonHandler{
    func passPlaceId(placeId: Int) {
        self.placeId = placeId
        performSegue(withIdentifier: "goToDescription", sender: self)
    }
    
    func getId(id: Int, title: String) {
        self.categoryId = id
        self.categoryName = title
        performSegue(withIdentifier: "goToExplore", sender: self)
    }
}




extension ExplainTableViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textIntoSearchBar = searchBar.text
        performSegue(withIdentifier: "goToSearch", sender: self)
      
    }
    
}



extension ExplainTableViewController:ExplainViewModelControllerDelegate{
    func sendCategories(_ data: [ExplainViewModel]) {
        categories = data
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
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
