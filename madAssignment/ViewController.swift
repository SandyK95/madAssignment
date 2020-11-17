//
//  ViewController.swift
//  madAssignment
//
//  Created by MAD2 on 3/1/19.
//  Copyright © 2019 MAD2. All rights reserved.
//

import UIKit
import iOSPhotoEditor

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBAction func creditBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewControllerID") as! ThirdViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnImport(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                image.sourceType = .camera
                self.present(image, animated: true, completion: nil)
            }
            else
            {
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in

            image.sourceType = .photoLibrary
            self.present(image,animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        myImageView.image = image
        self.dismiss(animated: true, completion: nil)
        
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        
        
        photoEditor.photoEditorDelegate = self
        
        
        //The image to be edited
        photoEditor.image = image
        
        //Stickers that the user will choose from to add on the image
        //photoEditor.stickers.append(UIImage(named: "sticker" )!)
        
        //Optional: To hide controls - array of enum control
        photoEditor.hiddenControls = [.crop, .draw, .share]
        
        //Optional: Colors for drawing and Text, If not set default values will be used
        photoEditor.colors = [.red,.blue,.green]
        

  
        //Stickers that the user will choose from to add on the image
        let filemanager = FileManager.default
        let imagePath = Bundle.main.resourcePath! + "/1"
        let imageNames = try!filemanager.contentsOfDirectory(atPath: imagePath)
       
        
        for image in imageNames {
            if let imageP = Bundle.path(forResource: image, ofType: nil, inDirectory: imagePath) {
                photoEditor.stickers.append(UIImage(contentsOfFile: imageP)!)
            }
        }
        
        for i in 0...2 {
            photoEditor.stickers.append(UIImage(named: i.description )!)
        }
        
        //To hide controls - array of enum control
        photoEditor.hiddenControls = [.crop, .draw, .share]
        
        //Present the View Controller
        present(photoEditor, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // btnImport.any.backgroundColor = UIColor.blue
        //self.view.backgroundColor = UIColor(red: 255/255, green: 207/255, blue: 84/255, alpha: 1)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        //Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
    }
    
}

extension ViewController: PhotoEditorDelegate {
    
    func doneEditing(image: UIImage) {
        myImageView.image = image
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewControllerID") as! SecondViewController
        
        vc.theImagePassed = myImageView.image!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func canceledEditing() {
        print("Canceled")
    }
    
}

