//
//  MainVC.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import EZSwiftExtensions
import UIKit

class MainVC: CardVC {

    var tutorialContainer: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QL1("MainVC loaded")
        view.backgroundColor = Utility.TeamRedColor
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clearColor()
            
            tutorialContainer = UIView()
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            let handIndicatorGif = UIImage.gifWithName("HandIndicator")
            let handIndicatorGifView = UIImageView(x: ez.screenWidth / 2 - 110, y: ez.screenHeight - 400, w: 220, h: 400, image: handIndicatorGif!)
            
            tutorialContainer?.addSubview(blurEffectView)
            tutorialContainer?.addSubview(handIndicatorGifView)
            
            self.view.addSubview(tutorialContainer!)
            
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
            tap.delegate = self
            self.view.addGestureRecognizer(tap)
        } 
        else {
            self.view.backgroundColor = UIColor.blackColor()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ContentOrganizer.Cards.isEmpty {
            ContentOrganizer.nextCard()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        QL3("Memory Warning")
    }
    
    func handleTap() {
        print("tap working")
        UIView.animateWithDuration(1.5 as NSTimeInterval, animations: {
            self.tutorialContainer!.alpha = 0
            }, completion: {
                finished in
                self.tutorialContainer!.alpha = 1
                self.tutorialContainer!.removeFromSuperview()
        })
    }
    
    //==========================================================================================================
    // MARK: - Custom card creation
    //==========================================================================================================
    
    func createNewCard() {
        //        currentCardIndex = CardLoader.nextAvailableCard()
        //        QL2("card id \(currentCardIndex)")
        QL2("Creating Card")
        
        if ContentOrganizer.Cards.isEmpty {
            ContentOrganizer.CardsFinished = true
        } else {
            let newCard = createMainCardFromData(data: ContentOrganizer.Cards.first!)
            newCard.createView(sender: self, border: false, shadow: false, check: true, cross: true)
            
            setupCard(card: newCard, canSendLeft: true, canSendRight: true, enableMovement: true)
            ContentOrganizer.CardsFinished = false
            
            let id = ContentOrganizer.Cards.first?.id
            if (id!.isEven) {
                view.backgroundColor = Utility.TeamRedColor
            } else {
                view.backgroundColor = Utility.TeamBlueColor
            }
        }
    }
    
    //==========================================================================================================
    // MARK: - CardVC methods
    //==========================================================================================================
    
    override func cardWasDragged(gesture: UIPanGestureRecognizer) {
        super.cardWasDragged(gesture)
    }
    
    override func swipeAnimationCompleted(card card: UIView) {
        super.swipeAnimationCompleted(card: card)
        resetCard(card: card)
        createNewCard()
    }
    
    override func afterSwipeRightAction(card card: UIView, animationDuration: Double) {
        UserActions.swipeAction(cardData: ContentOrganizer.Cards.first!, direction: "right")
        super.afterSwipeRightAction(card: card, animationDuration: animationDuration)
        
        QL2("right")
    }
    
    override func afterSwipeLeftAction(card card: UIView, animationDuration: Double) {
        UserActions.swipeAction(cardData: ContentOrganizer.Cards.first!, direction: "left")
        super.afterSwipeLeftAction(card: card, animationDuration: animationDuration)
        
        QL2("left")
    }
    
    override func createScrollView() {
        super.createScrollView()
    }
}








