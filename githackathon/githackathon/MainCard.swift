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
    var personalityView: PersonalityView!
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
//        personalityView = PersonalityView(sender: self)
                
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
        
        getPersonalitiesAsync()

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
    
    func getPersonalitiesAsync() {
        if (data.twitter != nil) {
            ez.requestJSON("http://friend01k.herokuapp.com/api/twitter_watson/\(data.twitter!)", success: { (jsonData) -> Void in
                
                let JSON = jsonData as! NSDictionary
                
                for (k1,v1) in JSON["tree"] as! NSDictionary {
                    if k1 as! String == "children" {
                        for v2 in v1 as! NSArray {
                            for (k3,v3) in v2 as! NSDictionary {
                                if k3 as! String == "children" {
                                    for v4 in v3 as! NSArray {
                                        if v4["category"] as! String == "personality" {
                                            for v5 in v4["children"] as! NSArray {
                                                for v6 in v5["children"] as! NSArray {
                                                    var personality = CardData.Personality()
                                                    personality.name = v6["name"] as? String
                                                    personality.percentage = String(v6["percentage"] as! Float)
                                                    if (self.data.personalities == nil) {
                                                        self.data.personalities = [personality]
                                                    } else {
                                                        self.data.personalities!.append(personality)
                                                    }
                                                    
                                                    
                                                }
//                                                if self.data.delegate != nil {
//                                                    self.data.delegate!.personalityLoaded(self.data.personalities!)
//                                                }
                                                return
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    
                }
                
                }, error: { (err) -> Void in
                    QL4(err)
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
    
    func personalityLoaded(personalities: [CardData.Personality]) {
        QL2("loaded card image!")
        personalityView.updatePersonality(personalities)
    }
}


