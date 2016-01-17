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
    var imageView: ImageView!
    //==========================================================================================================
    // MARK: - CardView methods
    //==========================================================================================================
    override func setupView() {
        super.setupView()
        
        data = ContentOrganizer.Cards.first!
        data.delegate = self

        authorView = AuthorView(sender: self)
        
        if data.mediaURL != nil {
            imageView = ImageView(sender: self)
        }
        
        contentView = ContentView(sender: self)
        
        
        
        if let url = data.authorMediaURL {
            ez.requestImage(url, success: { (image) -> Void in
                self.data.authorMedia = image
                if self.data.delegate != nil {
                    self.data.delegate!.profileImageLoaded(image: image!)
                }
            })
        }

        if let url = data.mediaURL {
            ez.requestImage(url, success: { (image) -> Void in
                self.data.media = image
                if self.data.delegate != nil {
                    self.data.delegate!.imageLoaded(image: image!)
                }
            })
        }


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

extension MainCard: CardDataDelegate {
    func profileImageLoaded(image image: UIImage) {
        QL1("card profile image loaded!")
        authorView.updateProfileImage(image: image)
    }
    
    func imageLoaded(image image: UIImage) {
        QL2("loaded card image!")
        imageView.updateImage(image: image)
    }
}


