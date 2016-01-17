//
//  MainCard.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class MainCard: CardView {
    
    //==========================================================================================================
    // MARK: - UI variables
    //==========================================================================================================
    var data = CardData()

    // New stuff
    var authorView: AuthorView!
    var contentView: ContentView!
//    var imageView: ImageView!
    //==========================================================================================================
    // MARK: - CardView methods
    //==========================================================================================================
    override func setupView() {
        super.setupView()
        
        data = ContentOrganizer.Cards.first!

        authorView = AuthorView(sender: self)
        contentView = ContentView(sender: self)
        

        self.layer.cornerRadius = 6
        
        adjustViewSizes(animated: false, resize: false)
    }
    
    override func cardCreationDidFinish() {
        super.cardCreationDidFinish()
        if cardCreationDidFinishEnabled {
            layer.opacity = 0
            UIView.animateWithDuration(0.5, animations: {
                self.layer.opacity = 1
                }, completion: { (value: Bool) in
                    self.cardReady = true
            })
        }
    }
    

}



