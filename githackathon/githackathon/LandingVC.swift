//
//  LandingVC.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class LandingVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purpleColor()
        
        let scaledImage = Utility.imageResize(UIImage(named: "BackgroundLanding")!, sizeChange: CGSize(width: ez.screenWidth, height: ez.screenHeight))
        
        self.view.backgroundColor = UIColor(patternImage: scaledImage)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(1)
        
        self.presentViewController(VCOrganizer.MainVCHolder, animated: true, completion: nil)
    }
}
