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
        
        let scaledImage = Utility.imageResize(UIImage(named: "SplashScreen")!, sizeChange: CGSize(width: ez.screenWidth, height: ez.screenHeight))
        self.view.backgroundColor = UIColor(patternImage: scaledImage)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(1)
        
        let scaledImage = Utility.imageResize(UIImage(named: "LandingBackground")!, sizeChange: CGSize(width: ez.screenWidth, height: ez.screenHeight))
        self.view.backgroundColor = UIColor(patternImage: scaledImage)
        
        let xButton = UIButton(x: 40, y: 440, w: 300, h: 50)
        xButton.backgroundColor = UIColor.clearColor()
        xButton.setTitle("FOLLOW ALONG LIVE GAME", forState: UIControlState.Normal)
        xButton.titleLabel?.font = UIFont(name: Utility.ThemeFontName, size: 16)
        xButton.layer.borderWidth = 1
        xButton.layer.borderColor = UIColor.whiteColor().CGColor
        xButton.alpha = 0.2
//        xButton.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(xButton)
        
        let yButton = UIButton(x: 40, y: 510, w: 300, h: 50)
        yButton.backgroundColor = UIColor.clearColor()
        yButton.setTitle("BASIC FOOTBALL KNOWLEDGE", forState: UIControlState.Normal)
        yButton.titleLabel?.font = UIFont(name: Utility.ThemeFontName, size: 16)
        yButton.layer.borderWidth = 1
        yButton.layer.borderColor = UIColor.whiteColor().CGColor
        yButton.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yButton)
        
    }
    
    
    
    func buttonAction() {
        self.presentViewController(VCOrganizer.MainVCHolder, animated: true, completion: nil)
    }

}

