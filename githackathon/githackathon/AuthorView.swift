//
//  AuthorView.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

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
        if currentCardView.data.image != nil {
            profileImageView = UIImageView(x: (sender.CardWidth / 2) - Constants.ImageHeight / 2, y: -(Constants.ImageHeight/2), w: Constants.ImageHeight, h: Constants.ImageHeight, image: currentCardView.data.image!)
        } else {
            profileImageView = UIImageView(x: (sender.CardWidth / 2) - Constants.ImageHeight / 2, y: 0, w: Constants.ImageHeight, h: Constants.ImageHeight, imageName: "Placeholder")
        }
        //        profileImageView.backgroundColor = UIColor.grayColor()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.grayColor().CGColor
        profileImageView.roundSquareImage()
        profileView.addSubview(profileImageView)
        //============================== profileImageView ==============================
        
        //============================== Nick Label ==============================
        let nickLabel = UILabel(x: 0, y: 0, w: Constants.WidthToResize, h: Constants.NameHeight)
//        nickLabel.backgroundColor = UIColor.redColor()
        nickLabel.textAlignment = NSTextAlignment.Left
        nickLabel.font = UIFont(name: Utility.ThemeFontName, size: 14)
        nickLabel.text = currentCardView.data.name
        nickLabel.resizeToFitWidth()
        nickLabel.frame = CGRect(x: (sender.CardWidth - nickLabel.w) / 2, y: profileImageView.bottomOffset(20), w: Constants.WidthToResize, h: Constants.NameHeight)
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
    
}
