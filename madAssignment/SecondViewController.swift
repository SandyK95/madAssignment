//
//  SecondViewController.swift
//  madAssignment
//
//  Created by MAD2 on 9/1/19.
//  Copyright © 2019 MAD2. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var theImagePassed = UIImage()
    
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBAction func shareImageTapped(_ sender: Any)
    {
        guard let image = secondImage.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //prepare(for: UIStoryboardSegue, sender: Any?)
        print("got")
        
        
        // Do any additional setup after loading the view.
        secondImage.image = theImagePassed
        //self.view.backgroundColor = UIColor(red: 255/255, green: 207/255, blue: 84/255, alpha: 1)
       
        //Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-share")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

    }
}

extension UIActivity.ActivityType {
    @available(iOS 7.0, *)
    public static let postToInstagram: UIActivity.ActivityType = {
        return UIActivity.ActivityType.init(rawValue: "com.burbn.instagram.shareextension")
    }()
}



