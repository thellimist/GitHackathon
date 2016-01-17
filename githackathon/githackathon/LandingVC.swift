//
//  LandingVC.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit

class LandingVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purpleColor()
        
        // Change this with orijinal image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "TestImage")!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(1)
        
        self.presentViewController(VCOrganizer.MainVCHolder, animated: true, completion: nil)
    }
}
