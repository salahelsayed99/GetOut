//
//  SettingsViewController.swift
//  Get Me Out
//
//  Created by Salah  on 28/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let userDefault = UserDefaults.standard
       
  
    var settings = [Settings]()
    
    
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
            // Do any additional setup after loading the view.
        settings.append(Settings(image: UIImage(systemName: "info.circle.fill")!, label: "About"))
        settings.append(Settings(image: UIImage(systemName: "doc.on.doc.fill")!, label: "Policy"))
        settings.append(Settings(image: UIImage(systemName: "person.fill")!, label: "Edit Profile"))
        settings.append(Settings(image: UIImage(systemName: "arrow.right.circle.fill")!, label: "Log out"))
        tableView.separatorStyle = .none
        //tableView.rowHeight = 65
      }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingsTableViewCell
        
        cell.settings = settings[indexPath.row]
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "", sender: self)
        case 1:
            performSegue(withIdentifier: "goToEdit", sender: self)
        case 2:
            performSegue(withIdentifier: "goToEdit", sender: self)
        case 3:
            userDefault.removeObject(forKey: "userToken")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "first") as!UINavigationController
            nextViewController.modalPresentationStyle = .fullScreen
             self.present(nextViewController, animated: true, completion: nil)
        default:
            performSegue(withIdentifier: "", sender: self)
        }
    }
    
}


