//
//  StartVC.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import Foundation
import UIKit
import EZSwipeController

struct VCOrganizer {
    
    static var MainVCHolder: MainVC!
    
    static func loadVC() {
        MainVCHolder = MainVC()
    }
}

class MotherVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellowColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.presentViewController(VCOrganizer.MainVCHolder, animated: false, completion: nil)
    }
}