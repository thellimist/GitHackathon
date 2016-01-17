//
//  PersonalityView.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 17/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import Foundation

class PersonalityView: CardSubView {
    
    private struct Constants {
        static let Padding: CGFloat = 5
    }
    
    var containerView: UIView!
    
    //==========================================================================================================
    // MARK: - Setup
    //==========================================================================================================
    
    override func setupView(sender sender: MainCard) {
        super.setupView(sender: sender)
        //        backgroundColor = UIColor.purpleColor() test test
        
        containerView = UIView()
        addSubview(containerView)

    }
    
    init(sender: MainCard) {
        super.init(frame: CGRect(x: 0, y: 0, w: sender.CardWidth, h: sender.CardWidth))
        setupView(sender: sender)
        sender.addSubview(self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 100, y: 100, w: 100, h: 100))
    }
    
    //==========================================================================================================
    // MARK: - Actions
    //==========================================================================================================
    
    var i = 0
    
    func updatePersonality(personalities: [CardData.Personality]) {
//        if let personalities = currentCardView.data.personalities {
//            for personality in personalities {
//                QL4("QQ \(personality.name)")
//                QL4("QQ \(personality.percentage)")
//                ez.runThisInMainThread({ () -> Void in
//                    let textView = UITextView(x: 10, y: CGFloat(self.i * 20), w: self.w - 20, h: self.h - 10)
//                    textView.font = UIFont(name: Utility.ThemeFontName, size: 20)
//                    textView.textAlignment = NSTextAlignment.Left
//                    textView.text = personality.name! + " " + personality.percentage!
//                    textView.scrollsToTop = false
//                    textView.selectable = true
//                    
//                    self.containerView.addSubview(textView)
//                    self.i++
//                })
//            }
//        }
//        currentCardView.adjustViewSizes(animated: false, resize: true)
    }
}



