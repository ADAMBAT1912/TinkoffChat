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
    
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBAction func colorButtons(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            label.textColor = UIColor.black
        case 2:
            label.textColor = UIColor.red
        case 3:
            label.textColor = UIColor.green
        case 4:
            label.textColor = UIColor.blue
        case 5:
            label.textColor = UIColor.magenta
        default:
            label.textColor = UIColor.darkGray
        }
        
  
    }
    
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
            
            self.imagePicker.allowsEditing = false
            
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
            
            self.profileField.delegate = self
            
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
           
            view.addGestureRecognizer(swipeGesture)
           
            swipeGesture.direction = UISwipeGestureRecognizerDirection.down
            
        
    }
    
    func swipeAction(){
       
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
      
        
       print("Сохранение данных профиля")
      
        
    }
    
    
}

