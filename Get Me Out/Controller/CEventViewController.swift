//
//  CEventViewController.swift
//  Get Me Out
//
//  Created by Salah  on 05/04/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class CEventViewController: UIViewController {
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventPlaceName: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet{
            let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
            descriptionTextView.layer.borderWidth = 0.5
            descriptionTextView.layer.borderColor = borderColor.cgColor
            descriptionTextView.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var shareFacebook: UIButton!{
        didSet{
            self.shareFacebook.rounded()
        }
    }
    
    let url = URL(string: "https://www.youtube.com/watch?v=EhyI-B0iMFY&list=LL3juQLqbPMhh1p5g8Cm-JCw&index=4&t=0s")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .dateAndTime
    }
    
    @IBAction func addCover(_ sender: UIButton) {
        showChooseSourceTypeAlertController()
    }
    
 
    
    @IBAction func valueChanged(sender:UIDatePicker,forEvent event: UIEvent ){
        let month = sender.date.getYearMonthDayHourMinute().month
        let day = sender.date.getYearMonthDayHourMinute().day
        let hour = sender.date.getYearMonthDayHourMinute().hour
        let minute = sender.date.getYearMonthDayHourMinute().minute
         print(month,day,hour,minute)
    }
    
    
    @IBAction func shareEvent(_ sender: UIButton) {
        let vc = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
               //print("done")
               present(vc, animated: true, completion: nil)
        
    }
    
    
}



extension CEventViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alert = AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction,cameraAction,cancelAction], completion: nil)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showImagePickerController(sourceType:UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate=self
        imagePickerController.allowsEditing=true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            eventImage.image=editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            eventImage.image=originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
