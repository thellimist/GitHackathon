//
//  CardVC.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class CardVC: UIViewController {
    
    private struct SwipeConstants {
        static let ActionMargin: CGFloat = 50        // Distance from center where the action applies. Higher = swipe further in order for the action to be called
        static let ScaleStrength = 4                 // How quickly the card shrinks. Higher = slower shrinking
        static let ScaleMax: CGFloat = 0.93          // Upper bar for how much the card shrinks. Higher = shrinks less
        static let RotationMax: CGFloat = 1.0        // Maximum rotation allowed in radians. Higher = card can keep rotating longer
        static let RotationStrength: CGFloat = 320.0 // Strength of rotation. Higher = weaker rotation
        static let RotationAngle = M_PI/8            // Higher = stronger rotation angle
    }
    //==========================================================================================================
    // MARK: - Swipe variables
    //==========================================================================================================
    private var xDistanceFromCenter: CGFloat = 0
    private var yDistanceFromCenter: CGFloat = 0
    private var originalPoint: CGPoint = CGPointMake(0, 0)
    var canSendCardLeft = false
    var canSendCardRight = false
    var canMove = false
    var cardStartPoint: CGPoint = CGPointMake(0, 0)
    //==========================================================================================================
    // MARK: - UI variables
    //==========================================================================================================
    var currentCard: CardView?
    var gestureRecognizer: UIPanGestureRecognizer?
    var scrollView = UIScrollView()
    var cardWidth = ez.screenWidth * 28 / 30  // old value: 26/30
    //==========================================================================================================
    // MARK: - Keyboard variables
    //==========================================================================================================
    var keyboardShowing = false
    //==========================================================================================================
    // MARK: - UIViewController methods
    //==========================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI stuff
        view.backgroundColor = UIColor.greenColor()
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissIfKeyboardIsShowing")
        view.addGestureRecognizer(tap)
        
//        view.h = VCOrganizer.HeightBetweenNavBarAndStatusBar
        createScrollView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        dismissIfKeyboardIsShowing()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //==========================================================================================================
    // MARK: - Card setup methods
    //==========================================================================================================
    
    func setupCard(card card: CardView, canSendLeft: Bool, canSendRight: Bool, enableMovement: Bool) {
        currentCard = card
        canSendCardLeft = canSendLeft
        canSendCardRight = canSendRight
        canMove = enableMovement
        if enableMovement {
            enableCardMovement(card: card)
        }
        cardStartPoint = card.center
        
        scrollView.addSubview(card)
    }
    
    func enableCardMovement(card card: CardView) {
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("cardWasDragged:"))
        gestureRecognizer!.delegate = self
        card.addGestureRecognizer(gestureRecognizer!)
    }
    
    // TODO: Why is this even here?
    func createMainCardFromData(data data: CardData) -> CardView {
        let newCard = MainCard()
        newCard.data = data
        return newCard
    }
    
    //==========================================================================================================
    // MARK: - ScrollView methods
    //==========================================================================================================
    
    func createScrollView() {
        scrollView.frame = view.frame
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollEnabled = true
        scrollView.scrollsToTop = false
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.sizeToFit()
        scrollView.contentSize = CGSize(width: cardWidth, height: 100)
        view.addSubview(scrollView)
    }
    
    func updateScrollViewContentSize(newheight newheight: CGFloat) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: newheight)
    }
    
    func scrollToBottom() {
        QL2("Scrolling to bottom")
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    func scrollToTop() {
        QL2("Scrolling to top")
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    //==========================================================================================================
    // MARK: - Drag & Swipe methods
    //==========================================================================================================
    
    func cardWasDragged(gesture: UIPanGestureRecognizer) {
        if keyboardShowing {
            return
        }
        
        let label = gesture.view!
        xDistanceFromCenter = gesture.translationInView(view).x // Positive for right swipe, negative for left
        yDistanceFromCenter = gesture.translationInView(view).y // Positive for up, negative for down
        
        cardMoved(xDistanceFromCenter: xDistanceFromCenter, yDistanceFromCenter: yDistanceFromCenter, actionMargin: SwipeConstants.ActionMargin)
        
        if currentCard?.stayInMiddle == false {
            if abs(yDistanceFromCenter) > abs(xDistanceFromCenter) {
                cardBackToCenter(card: label)
                return
            }
        }
        
        switch gesture.state {
        case UIGestureRecognizerState.Began:
            QL2("began")
            originalPoint = label.center
        case UIGestureRecognizerState.Changed:
            
            var editedRotationStr = SwipeConstants.RotationStrength
            if currentCard?.frame.height > ez.screenHeight {
                editedRotationStr *= 2
            }
            
            // Dictates rotation
            let rotationStrength: CGFloat = min(xDistanceFromCenter / editedRotationStr, SwipeConstants.RotationMax)
            // Degree change in radians
            let rotationAngle: CGFloat = (CGFloat) (CGFloat(SwipeConstants.RotationAngle) * rotationStrength)
            // Amount height changes when you move the card up to a certain point
            let scale: CGFloat = max(1 - CGFloat(fabsf(Float(rotationStrength))) / CGFloat(SwipeConstants.ScaleStrength), SwipeConstants.ScaleMax)
            // Rotate by certain amount
            let transform: CGAffineTransform  = CGAffineTransformMakeRotation(rotationAngle)
            // Scale by certain amount
            let scaleTransform: CGAffineTransform  = CGAffineTransformScale(transform, scale, scale)
            // Apply transformations
            label.transform = scaleTransform
            
            // Move the object's center by center + gesture coordinate
            label.center = CGPointMake(originalPoint.x + xDistanceFromCenter, self.originalPoint.y + yDistanceFromCenter)
        case UIGestureRecognizerState.Ended:
            afterSwipeAction(card: label)
            QL2("Ended")
        default: print("Finished Swiping")
        }
    }
    
    func afterSwipeAction(card card: UIView) {
        if canSendCardRight && xDistanceFromCenter > SwipeConstants.ActionMargin {
            afterSwipeRightAction(card: card, animationDuration: 0.3)
        } else if canSendCardLeft && xDistanceFromCenter < -SwipeConstants.ActionMargin {
            afterSwipeLeftAction(card: card, animationDuration: 0.3)
        } else {
            cardBackToCenter(card: card)
        }
    }
    
    func cardBackToCenter(card card: UIView) {
        cardMoved(xDistanceFromCenter: 0, yDistanceFromCenter: 0, actionMargin: SwipeConstants.ActionMargin)
        UIView.animateWithDuration(0.15, animations: {
            card.center = self.cardStartPoint
            card.transform = CGAffineTransformMakeRotation(0)
        })
    }
    
    func afterSwipeRightAction(card card: UIView, animationDuration: Double) {
        let distanceBetweenCenter: CGFloat = CGFloat(Utility.getValueForCurrentScreenSize(iphone4: 500, iphone5: 500, iphone6: 500, iphone6p: 500, ipad: 800))
        
        let finishPoint: CGPoint = CGPointMake(view.center.x + distanceBetweenCenter, self.cardStartPoint.y)
        UIView.animateWithDuration(animationDuration, animations: {
            //TODO: at 3 its really cute try it, at last card to this
            self.scrollToTop()
            card.center = finishPoint
            }, completion: { (value: Bool) in
                self.swipeAnimationCompleted(card: card)
        })
    }
    
    func afterSwipeLeftAction(card card: UIView, animationDuration: Double) {
        let distanceBetweenCenter: CGFloat = CGFloat(Utility.getValueForCurrentScreenSize(iphone4: 500, iphone5: 500, iphone6: 500, iphone6p: 500, ipad: 800))
        
        let finishPoint: CGPoint = CGPointMake(view.center.x - distanceBetweenCenter, self.cardStartPoint.y)
        UIView.animateWithDuration(animationDuration, animations: {
            //TODO: at 3 its really cute try it, at last card to this
            self.scrollToTop()
            card.center = finishPoint
            }, completion: { (value: Bool) in
                self.swipeAnimationCompleted(card: card)
        })
    }
    
    func swipeAnimationCompleted(card card: UIView) {
        // Override this func
    }
    
    func resetCard(card card: UIView) {
        currentCard!.cardBeforeDelete()
        for someView in card.subviews {
            someView.removeFromSuperview()
        }
        card.removeFromSuperview()
        currentCard = nil
    }
    
    //==========================================================================================================
    // MARK: - Card movement
    //==========================================================================================================
    
    func cardMoved(xDistanceFromCenter xDistanceFromCenter: CGFloat, yDistanceFromCenter: CGFloat, actionMargin: CGFloat) {
        currentCard!.cardMoved()
        
        // TODO: Maybe this guy shouldn't know if current cards imageview nil or not
        if xDistanceFromCenter > 0 && currentCard!.rightImageView != nil {
            currentCard!.setRightSwipeImageOpacity(xDistanceFromCenter: xDistanceFromCenter, actionMargin: actionMargin)
        } else if xDistanceFromCenter < 0 && currentCard!.leftImageView != nil {
            currentCard!.setLeftSwipeImageOpacity(xDistanceFromCenter: xDistanceFromCenter, actionMargin: actionMargin)
        }
        
        if xDistanceFromCenter > actionMargin {
            cardPassedRightMargin()
        } else if xDistanceFromCenter < -actionMargin {
            cardPassedLeftMargin()
        } else {
            cardInMiddleArea()
        }
    }
    
    func cardPassedRightMargin() {
        // Override this func
    }
    
    func cardPassedLeftMargin() {
        // Override this func
    }
    
    func cardInMiddleArea() {
        // Override this func, it is called if card is between right and left margins
    }
    
    //==========================================================================================================
    // MARK: - Keyboard methods
    //==========================================================================================================
    
    func dismissIfKeyboardIsShowing() {
        if keyboardShowing == true {
            keyboardShowing = false
            view.endEditing(true)
        }
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        keyboardShowing = true
        keyboardResize(notification: notification)
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        keyboardShowing = false
        keyboardResize(notification: notification)
        currentCard?.cardSizeChanged()
    }
    
    func keyboardResize(notification notification: NSNotification) {
        
    }
    
    func afterKeyboardResize(keyboardModifier: CGFloat) {
        
    }
    
}

//==========================================================================================================
// MARK: - UIScrollViewDelegate
//==========================================================================================================

extension CardVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        originalPoint = currentCard!.center
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // TODO: furkan find a way to reduce this part to 1 if
        if xDistanceFromCenter > SwipeConstants.ActionMargin || xDistanceFromCenter < -SwipeConstants.ActionMargin {
            
        } else if currentCard!.center != cardStartPoint {
            cardBackToCenter(card: currentCard!)
        }
    }
}

//==========================================================================================================
// MARK: - UIGestureRecognizerDelegate
//==========================================================================================================

extension CardVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


