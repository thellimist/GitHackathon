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
    static var LandingVCHolder: LandingVC!
    
    static func loadVC() {
        MainVCHolder = MainVC()
        LandingVCHolder = LandingVC()
    }
}
