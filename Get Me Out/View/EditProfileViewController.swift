//
//  EditProfileViewController.swift
//  Get Me Out
//
//  Created by Salah  on 27/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBOutlet weak var personalImage: UIImageView!


    @IBOutlet weak var nameTextField: UITextField!{
        didSet{
            self.nameTextField.setBottomBorder()
        }
    }
    @IBOutlet weak var numberTextField: UITextField!{
        didSet{
            self.numberTextField.setBottomBorder()
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            self.emailTextField.setBottomBorder()
        }
    }

    @IBOutlet weak var locationTextField: UITextField!{
        didSet{
            self.locationTextField.setBottomBorder()
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            self.passwordTextField.setBottomBorder()
        }
    }
    @IBOutlet weak var confirmButton: UIButton!{
        didSet{
            self.confirmButton.rounded()
        }
    }

    @IBAction func confirmBtn(_ sender: UIButton) {
    }
    @IBAction func changePersonalImage(_ sender: UIButton) {
        showChooseSourceTypeAlertController()

    }
}

extension EditProfileViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
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
            personalImage.image=editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            personalImage.image=originalImage
        }

        dismiss(animated: true, completion: nil)
    }

}
