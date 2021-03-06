//
//  AuthorView.swift
//  Qorum
//
//  Created by Goktug Yilmaz on 07/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit
import EZAlertController
import EZSwiftExtensions

class AuthorView: CardSubView {
    
    private struct Constants {
        static let ImageHeight: CGFloat = 80
        static let WidthToResize: CGFloat = 300
        static let NameHeight: CGFloat = 25
        static let TitleHeight: CGFloat = 15
        static let Padding: CGFloat = 2
    }

    var profileImageView: UIImageView!

    override func setupView(sender sender: MainCard) {
        super.setupView(sender: sender)
        
        let insideFrame = UIView(superView: self, padding: Constants.Padding)
//        insideFrame.backgroundColor = UIColor.yellowColor()
        
        let profileView = UIView()
        insideFrame.addSubview(profileView)
        //============================== profileImageView ==============================
        let circle = UIView(x: (sender.CardWidth / 2) - Constants.ImageHeight / 2, y: -(Constants.ImageHeight/2), w: Constants.ImageHeight + 8, h: Constants.ImageHeight + 8)
            
        circle.drawCircle(fillColor: UIColor.whiteColor(), strokeColor: UIColor(r: 220, g: 220, b: 220), strokeWidth: 1)
        
        if currentCardView.data.authorMedia != nil {
            profileImageView = UIImageView(x: 4, y: 4, w: currentCardView.data.authorMedia!.size.width, h: currentCardView.data.authorMedia!.size.height, image: currentCardView.data.authorMedia!)
        } else {
            profileImageView = UIImageView(x: 4, y: 4, w: Constants.ImageHeight, h: Constants.ImageHeight, imageName: "AuthorImagePlaceholder")
        }
        //        profileImageView.backgroundColor = UIColor.grayColor()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor(r: 220, g: 220, b: 220).CGColor
        profileImageView.roundSquareImage()
        profileImageView.backgroundColor = UIColor.whiteColor()
        
        circle.addSubview(profileImageView)
        profileView.addSubview(circle)
        //============================== profileImageView ==============================
        
        //============================== Nick Label ==============================
        let nickLabel = UILabel(x: 0, y: 0, w: Constants.WidthToResize, h: Constants.NameHeight)
//        nickLabel.backgroundColor = UIColor.redColor()
        nickLabel.textAlignment = NSTextAlignment.Left
        nickLabel.font = UIFont(name: Utility.ThemeFontName, size: 16)
        if currentCardView.data.authorName == nil {
            nickLabel.text = "FUN FACT"
        } else {
            nickLabel.text = currentCardView.data.authorName?.uppercaseString
        }
        nickLabel.resizeToFitWidth()
        nickLabel.frame = CGRect(x: (sender.CardWidth - nickLabel.w) / 2, y: circle.bottomOffset(12), w: Constants.WidthToResize, h: Constants.NameHeight)
        nickLabel.resizeToFitWidth()
        profileView.addSubview(nickLabel)
        //============================== Nick Label ==============================
        
        //============================== Info Button ==============================
        let infoButton = UIButton(x: sender.CardWidth - 10 - 24, y: 10, w: 24, h: 24)
        infoButton.setImage(UIImage(named: "statistics"), forState: .Normal)
        infoButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        //============================== Info Button ==============================
        
        addSubview(insideFrame)
        addSubview(infoButton)
    }
    
    init(sender: MainCard) {
        super.init(frame: CGRect(x: 0, y: 0, w: sender.CardWidth, h: Constants.ImageHeight + 20 ))
        setupView(sender: sender)
        sender.addSubview(self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 100, y: 100, w: 100, h: 100))
    }
    
    var containerView: UIView?
    func close(sender:UIButton!) {
        containerView?.removeFromSuperview()
    }
    
    func buttonAction(sender:UIButton!)
    {
        QL4("Button tapped")
        
        var emojiList = ["Aventurousness": " 🏄",
                        "Intellect": "🤔",
                        "Authority-challenging": "👻",
                        "Artistic interests": "🎭",
                        "Emotionality": "😳",
                        "Imagination": "👽"]
        
        
        if let tw = currentCardView.data.twitter {
            
            containerView = UIView(x: 30, y: 150, w: 350, h: 350)
//            containerView.backgroundColor = UIColor.blueColor()
            
            let webV: UIWebView = UIWebView(frame: CGRectMake(10, 10, 300, 350))
            webV.loadRequest(NSURLRequest(URL: NSURL(string: "http://friend01k.herokuapp.com/secret/twitter_watson/\(tw)")!))
            containerView!.addSubview(webV)

            let backButton = UIButton(x: 85, y: 310, w: 150, h: 40)
            backButton.setTitle("Close", forState: .Normal)
            backButton.backgroundColor = UIColor.blackColor()
            backButton.titleLabel?.font = UIFont(name: Utility.ThemeFontName, size: 16)
//            backButton.titleLabel?.textColor = UIColor.blackColor()
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor = UIColor.blackColor().CGColor
            backButton.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView!.addSubview(backButton)
            
            
            
            containerView!.resizeToFitSubviews()
            
            ez.topMostVC!.view.addSubview(containerView!)
            
            
            
//            addSubview(containerView)
//            bringSubviewToFront(containerView)
//            bringSubviewToFront(webV)
        }
        
        
//        if let personalities = self.currentCardView.data.personalities {
//            var text = ""
//            for personality in personalities {
//                text += "\(personality.name!): \(personality.percentage!)\n"
//            }
//            
//            EZAlertController.alert(text)
//        }
    }
    
    func updateProfileImage(image image: UIImage) {
        profileImageView.image = image
        profileImageView.scaleImageFrameToWidth(width: Constants.ImageHeight)
    }
    
}

