//
//  TextView.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit

class ContentView: CardSubView {
    
    private struct Constants {
        static let HeightToResize: CGFloat = 300
        static let Padding: CGFloat = 20
    }
    
    override func setupView(sender sender: MainCard) {
        super.setupView(sender: sender)

//        backgroundColor = UIColor.greenColor()
        let contentTextView = UITextView(x: Constants.Padding, y: 0, w: w - Constants.Padding*2, h: h - Constants.Padding)
//                contentTextView.backgroundColor = UIColor.redColor()
        contentTextView.font = UIFont(name: Utility.ThemeFontName, size: 20)
        contentTextView.textAlignment = NSTextAlignment.Left
        contentTextView.text = currentCardView.data.text
        contentTextView.scrollsToTop = false
        contentTextView.selectable = true
        contentTextView.dataDetectorTypes = UIDataDetectorTypes.Link
        contentTextView.resizeToFitHeight()
        
        addSubview(contentTextView)
        resizeToFitSubviews()
        if (sender.data.mediaURL != nil) {
            contentTextView.frame.origin.y = 10
            contentTextView.font = UIFont(name: Utility.ThemeFontName, size: 16)
            contentTextView.resizeToFitHeight()
            resizeToFitSubviews()
        }
        w += Constants.Padding
        h += Constants.Padding
    }
    
    init(sender: MainCard) {
        super.init(frame: CGRect(x: 0, y: 0, w: sender.CardWidth, h: Constants.HeightToResize))
        setupView(sender: sender)
        sender.addSubview(self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 100, y: 100, w: 100, h: 100))
    }
}
