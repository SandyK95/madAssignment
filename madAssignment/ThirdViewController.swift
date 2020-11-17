//
//  ThirdViewController.swift
//  madAssignment
//
//  Created by Sandy Kee on 1/17/19.
//  Copyright © 2019 MAD2. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController{
    
    
    @IBOutlet weak var Credit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sandy = " Name: SANDY KEE, S10182285F"
        let stephanie = " Name: Stephanie, S10181909F"
        
        Credit.text?.append(sandy + "\n" + stephanie)
        
    }
}

