//
//  ViewController.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 06.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    private var tapCounter = 0
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var profileField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    @IBAction func chooseImage(_ sender: Any) {
       
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
        let alertMessage = UIAlertController(title: "Выбрать источник", message: "Откуда загрузить фото?", preferredStyle: .alert)
        let cameraRollAction = UIAlertAction(title: "Камера", style: .default) { action -> Void in
            
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        
           self.imagePicker.allowsEditing = true
            
            self.present(self.imagePicker ,animated: true)

        }
        let libraryAction = UIAlertAction(title: "Галерея", style: .default){ action -> Void in
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.imagePicker.allowsEditing = true
            
            self.present(self.imagePicker ,animated: true)

        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let defaultAction = UIAlertAction(title: "По умолчанию", style: .default){action -> Void in
            
            self.profileImage.image = #imageLiteral(resourceName: "1 копия")
        }
        alertMessage.addAction(cameraRollAction)
        alertMessage.addAction(libraryAction)
        alertMessage.addAction(cancelAction)
        alertMessage.addAction(defaultAction)
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
       {
        
        profileImage.image = image
        }
       else{
        print("Error")
        }
   
        self.dismiss(animated: true, completion: nil)
    
    
    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapAction) )
    view.addGestureRecognizer(tapGesture)
        
            self.profileField.delegate = self
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
            view.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = UISwipeGestureRecognizerDirection.down
            
    
        
    }
    
    func swipeAction(){
        view.endEditing(true)
    }
    
    func onTapAction(){
        view.endEditing(true)
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileField.resignFirstResponder()
        
        return (true)
    }
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let button: UIButton = sender as? UIButton else { return}
           tapCounter+=1
        button.setTitle("Нажато \(tapCounter) раз", for: .normal)
      
        
    }

}

