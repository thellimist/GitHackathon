//
//  AuthorView.swift
//  Qorum
//
//  Created by Goktug Yilmaz on 07/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit

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
        
        addSubview(insideFrame)
    }
    
    init(sender: MainCard) {
        super.init(frame: CGRect(x: 0, y: 0, w: sender.CardWidth, h: Constants.ImageHeight + 20 ))
        setupView(sender: sender)
        sender.addSubview(self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 100, y: 100, w: 100, h: 100))
    }
    
    func updateProfileImage(image image: UIImage) {
        profileImageView.image = image
        profileImageView.scaleImageFrameToWidth(width: Constants.ImageHeight)
    }
    
}

