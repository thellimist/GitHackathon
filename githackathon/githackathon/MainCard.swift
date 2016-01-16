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
//    var authorView: AuthorView!
//    var contentView: ContentView!
//    var imageView: ImageView!
    //==========================================================================================================
    // MARK: - CardView methods
    //==========================================================================================================
    override func setupView() {
        super.setupView()

        // Not used currently
        data = ContentOrganizer.Cards.first!

        let nickLabel = UILabel(x: 10, y: 10, w: ez.screenWidth, h: 100)
        nickLabel.backgroundColor = UIColor.redColor()
        nickLabel.textAlignment = NSTextAlignment.Left
        nickLabel.font = UIFont(name: Utility.ThemeFontName, size: 14)
        nickLabel.text = data.text
        nickLabel.resizeToFitWidth()
        self.addSubview(nickLabel)

        
        
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



