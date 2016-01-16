//
//  CardView.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class CardView: UIView {
    
    //==========================================================================================================
    // MARK: - Variables
    //==========================================================================================================
    var senderView: CardVC?
    var stayInMiddle = false
    var cardReady = false
    var rightImageView: UIImageView?
    var leftImageView: UIImageView?
    var rightImage: SwipeImage!
    var leftImage: SwipeImage!
    var customBorder: CAShapeLayer?
    var shadowEnabled = false
    var tagsToIgnore = [Int]()
    //var data: CardData!
    
    var cardCreationDidFinishEnabled = true
    
    enum SwipeImage {
        case CheckMark, CrossMark, Ok, Nothing
        
        init() {
            self = .Nothing
        }
        
        func normalValue() -> UIImage? {
            switch self {
            case .CheckMark: return UIImage(named: "save_text_crooked")
            case .CrossMark: return UIImage(named: "pass_text_crooked")
            case .Ok: return UIImage(named: "ok1")
            case .Nothing: return nil
            }
        }
        
        func activeValue() -> UIImage? {
            switch self {
            case .CheckMark: return UIImage(named: "save_text_crooked")
            case .CrossMark: return UIImage(named: "pass_text_crooked")
            case .Ok: return UIImage(named: "ok2")
            case .Nothing: return nil
            }
        }
    }
    
    //==========================================================================================================
    // MARK: - Constants
    //==========================================================================================================
    let CardWidth = ez.screenWidth * 28 / 30 // Old: 26/30
    //==========================================================================================================
    // MARK: - Card setup
    //==========================================================================================================
    func createView(sender sender: CardVC, border: Bool = false, shadow: Bool = false, cross: Bool = false, check: Bool = false, newPost: Bool = false, ok: Bool = false) {
        senderView = sender
        userInteractionEnabled = true
        backgroundColor = UIColor.whiteColor()
        layer.cornerRadius = 6
        
        setupView()
        shadowEnabled = shadow
        cardSizeChanged()
        
        if border {
            updateBorders()
        }
        
        if check {
            rightImage = SwipeImage.CheckMark
            createRightImageView()
        } else if ok {
            rightImage = SwipeImage.Ok
            createRightImageView()
        }
        
        if cross {
            leftImage = SwipeImage.CrossMark
            createLeftImageView()
        } else if ok{
            leftImage = SwipeImage.Ok
            createLeftImageView()
        }
        
        //contentMode = UIViewContentMode.ScaleAspectFit ????
        cardCreationDidFinish()
    }
    
    func setupView() {
        // Override this func
    }
    
    func adjustViewSizes(animated animated: Bool, resize: Bool) {
        if animated {
            UIView.animateWithDuration(0.5, animations: {
                self.cardSize(true)
            })
        } else {
            cardSize(true)
        }
        
        if resize {
            cardSizeChanged()
        }
    }
    
    //TODO: cardsize methods could be better named
    func cardSizeChanged() {
        let currentCardHeight = cardSize()
        frame = CGRect(x: ez.screenWidth * 1 / 30, y: 10 + 44, width: CardWidth, height: currentCardHeight)
        
        if senderView?.keyboardShowing == true {
            
        } else if frame.height < senderView!.scrollView.h {
            stayInMiddle = true
            //            frame.origin.y = senderView!.scrollView.h/2 - currentCardHeight/2
        } else {
            stayInMiddle = false
        }
        
        senderView?.updateScrollViewContentSize(newheight: currentCardHeight)
        senderView?.cardStartPoint = center
        
        if customBorder != nil {
            updateBorders()
        }
        
        if shadowEnabled {
            updateShadow()
        }
    }
    
    func cardSize(reorder: Bool = false) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).hidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
    
    func cardCreationDidFinish() {

    }
    
    //==========================================================================================================
    // MARK: - Create card accessories
    //==========================================================================================================
    
    func createRightImageView() {
        rightImageView = UIImageView(image: rightImage.normalValue())
        rightImageView!.tag = 755
        tagsToIgnore.append(755)
        rightImageView!.backgroundColor = UIColor.clearColor()
        rightImageView!.frame = CGRect(x: 30, y: 25, width: 90 * 1.48, height: 90)
        rightImageView!.hidden = true
        addSubview(rightImageView!)
    }
    
    func createLeftImageView() {
        leftImageView = UIImageView(image: leftImage.normalValue())
        leftImageView!.tag = 756
        tagsToIgnore.append(756)
        leftImageView!.backgroundColor = UIColor.clearColor()
        leftImageView!.frame = CGRect(x: CardWidth - 30 - 90 * 1.48, y: 25, width: 90 * 1.48, height: 90)
        leftImageView!.hidden = true
        addSubview(leftImageView!)
    }
    
    func updateBorders() {
        if customBorder != nil {
            customBorder?.removeFromSuperlayer()
        }
        customBorder = CAShapeLayer()
        customBorder!.strokeColor = UIColor(r: 227, g: 232, b: 235).CGColor
        customBorder!.fillColor = nil
        customBorder!.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height)).CGPath
        layer.addSublayer(customBorder!)
    }
    
    func updateShadow() {
        layer.shadowPath = createShadowPath().CGPath
        layer.masksToBounds = false
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
    }
    
    func createShadowPath() -> UIBezierPath {
        let myBezier = UIBezierPath()
        myBezier.moveToPoint(CGPoint(x: -3, y: -3))
        myBezier.addLineToPoint(CGPoint(x: frame.width + 3, y: -3))
        myBezier.addLineToPoint(CGPoint(x: frame.width + 3, y: frame.height + 3))
        myBezier.addLineToPoint(CGPoint(x: -3, y: frame.height + 3))
        myBezier.closePath()
        return myBezier
    }
    
    //==========================================================================================================
    // MARK: - Check cross mark functions
    //==========================================================================================================
    
    func setRightSwipeImageOpacity(xDistanceFromCenter xDistanceFromCenter: CGFloat, actionMargin: CGFloat) {
        let opacity = getMarkOpacity(xDistanceFromCenter: xDistanceFromCenter, actionMargin: actionMargin)
        rightImageView!.hidden = false
        rightImageView!.alpha = opacity
        if opacity == 1 {
            rightImageView!.image = rightImage.activeValue()
        } else {
            rightImageView!.image = rightImage.normalValue()
        }
    }
    
    func setLeftSwipeImageOpacity(xDistanceFromCenter xDistanceFromCenter: CGFloat, actionMargin: CGFloat) {
        let opacity = getMarkOpacity(xDistanceFromCenter: xDistanceFromCenter, actionMargin: actionMargin)
        leftImageView!.hidden = false
        leftImageView!.alpha = opacity
        if opacity == 1 {
            leftImageView!.image = leftImage.activeValue()
        } else {
            leftImageView!.image = leftImage.normalValue()
        }
    }
    
    func cardMoved() {
        hideCheckAndCrossImages()
    }
    
    func hideCheckAndCrossImages() {
        if rightImageView != nil {
            rightImageView!.hidden = true
        }
        
        if leftImageView != nil {
            leftImageView!.hidden = true
        }
    }
    
    func getMarkOpacity(xDistanceFromCenter xDistanceFromCenter: CGFloat, actionMargin: CGFloat) -> CGFloat {
        var markOpacity: CGFloat = 0
        if fabs(xDistanceFromCenter) > fabs(actionMargin) {
            markOpacity = 1
        } else {
            markOpacity = fabs(xDistanceFromCenter) / fabs(actionMargin)
        }
        return markOpacity
    }
    
    //==========================================================================================================
    // MARK: - Card general
    //==========================================================================================================
    
    func cardBeforeDelete() {
        // Override this func
    }
    
    func cardStillInView() -> Bool {
        if self == senderView?.currentCard {
            return true
        }
        return false
    }
    
}

