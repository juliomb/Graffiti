//
//  GraffitiDetailViewController.swift
//  Graffiti
//
//  Created by Timple Soft on 29/11/16.
//  Copyright © 2016 TimpleSoft. All rights reserved.
//

import UIKit

protocol GraffitiDetailViewControllerDelegate : class {
    func graffitiDidFinishGetTagged(sender: GraffitiDetailViewController, taggedGraffiti: Graffiti)
}

class GraffitiDetailViewController: UIViewController {

    weak var delegate: GraffitiDetailViewControllerDelegate?
    
    @IBOutlet weak var imgGraffiti: UIImageView!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    var taggedGraffiti : Graffiti?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "img_navbar_title"))
        
        let takePictureGesture = UITapGestureRecognizer(target: self, action: #selector(takePictureTapped))
        imgGraffiti.addGestureRecognizer(takePictureGesture)
        
        configureLabels()
    }

    
    func configureLabels() {
        lblLatitude.text = String(format: "%.8f", (taggedGraffiti?.coordinate.latitude)!)
        lblLongitude.text = String(format: "%.8f", (taggedGraffiti?.coordinate.longitude)!)
        lblAddress.text = taggedGraffiti?.address
    }
    

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if let image = imgGraffiti.image {
            let randomName = UUID().uuidString.appending(".png")
            if let url = GraffitiManager.sharedInstance.imagesURL()?.appendingPathComponent(randomName),
                let imgData = UIImagePNGRepresentation(image){
                do {
                    try imgData.write(to: url)
                } catch (let error) {
                    print("Error salvando la imagen: \(error)")
                }
            }
            if let taggedGraffiti = taggedGraffiti,
                let delegate = delegate{
                taggedGraffiti.imageName = randomName
                delegate.graffitiDidFinishGetTagged(sender: self, taggedGraffiti: taggedGraffiti)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension GraffitiDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func takePictureTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    
    func showPhotoMenu() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "Sacar foto", style: .default) { _ in
            self.takePhotoWithCamera()
        }
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: "Elegir de la librería", style: .default) { _ in
            self.choosePhotoFromLibrary()
        }
        alertController.addAction(chooseFromLibraryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func takePhotoWithCamera (){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageTaken = info[UIImagePickerControllerEditedImage] as? UIImage
        imgGraffiti.image = imageTaken
        btnSave.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
















