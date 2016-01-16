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
    
    var buttonsView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QL1("MainVC loaded")
        view.backgroundColor = UIColor.blueColor()
        
        createNewCard()
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
    
    func AddFakeCardData() {
        var cardData = CardData()
        cardData.text = "Cool my name is Furkan"
        
        ContentOrganizer.Cards.append(cardData)
    }
    
    //==========================================================================================================
    // MARK: - Custom card creation
    //==========================================================================================================
    
    func createNewCard() {
        AddFakeCardData()
        //        currentCardIndex = CardLoader.nextAvailableCard()
        //        QL2("card id \(currentCardIndex)")
        QL2("Creating Card")
        
        if ContentOrganizer.Cards.isEmpty {
            ContentOrganizer.CardsFinished = true
        } else {
            let newCard = createMainCardFromData(data: ContentOrganizer.Cards.first!)
            newCard.createView(sender: self, border: true, shadow: false, check: true, cross: true)
            
            setupCard(card: newCard, canSendLeft: true, canSendRight: true, enableMovement: true)
            ContentOrganizer.CardsFinished = false
        }
    }
    
    //==========================================================================================================
    // MARK: - QorumCardVC methods
    //==========================================================================================================
    
    override func cardWasDragged(gesture: UIPanGestureRecognizer) {
        super.cardWasDragged(gesture)
    }
    
    override func swipeAnimationCompleted(card card: UIView) {
        super.swipeAnimationCompleted(card: card)
        resetCard(card: card)
        createNewCard()
        buttonsView?.userInteractionEnabled = true
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
    
    override func afterKeyboardResize(keyboardModifier: CGFloat) {
        //        commentField.y -= keyboardModifier
    }
    
    override func createScrollView() {
        super.createScrollView()
        //        scrollView.h -= CommentFieldView.Constants.FieldHeight
    }
    
    override func keyboardWillAppear(notification: NSNotification) {
        super.keyboardWillAppear(notification)
        scrollToBottom()
    }
    
    //==========================================================================================================
    // MARK: - Break menu methods
    //==========================================================================================================
    
    func createButtonsView() {
        guard (buttonsView == nil) else {
            return
        }
        
        let buttonheight = ez.screenWidth / 3.5
        buttonsView = UIView(x: 0, y: ez.screenHeight - buttonheight * 1.6, w: ez.screenWidth, h: buttonheight)
        view.addSubview(buttonsView!)
        
        //============================== Left Button ==============================
        let leftButton = BlockButton { (sender) -> Void in
            QL1("Clicked left button")
            self.buttonsView!.userInteractionEnabled = false
            self.afterSwipeLeftAction(card: self.currentCard!, animationDuration: 0.3)
        }
        leftButton.backgroundColor = UIColor.clearColor()
        leftButton.layer.cornerRadius = 40
        leftButton.setImage(UIImage(named: "pass"), forState: .Normal)
        buttonsView!.addSubview(leftButton)
        
        let leftButtonLabel = UILabel()
        leftButtonLabel.backgroundColor = UIColor.clearColor()
        leftButtonLabel.textAlignment = NSTextAlignment.Center
        leftButtonLabel.font = UIFont(name: Utility.ThemeFontName, size: 14)
        leftButtonLabel.text = "Pass"
        leftButtonLabel.textColor = UIColor(r: 131, g: 131, b: 131)
        leftButtonLabel.resizeToFitWidth()
        buttonsView!.addSubview(leftButtonLabel)
        //============================== Left Button ==============================
        
        //============================== Right Button ==============================
        let rightButton = BlockButton { (sender) -> Void in
            QL1("Clicked right button")
            self.buttonsView!.userInteractionEnabled = false
            self.afterSwipeRightAction(card: self.currentCard!, animationDuration: 0.3)
        }
        rightButton.backgroundColor = UIColor.clearColor()
        rightButton.layer.cornerRadius = 40
        rightButton.setImage(UIImage(named: "archive"), forState: .Normal)
        buttonsView!.addSubview(rightButton)
        
        let rightButtonLabel = UILabel()
        rightButtonLabel.textAlignment = NSTextAlignment.Center
        rightButtonLabel.font = UIFont(name: Utility.ThemeFontName, size: 14)
        rightButtonLabel.text = "Save"
        rightButtonLabel.textColor = UIColor(r: 131, g: 131, b: 131)
        rightButtonLabel.resizeToFitWidth()
        buttonsView!.addSubview(rightButtonLabel)
        //============================== Right Button ==============================
        
        
        // Put Buttons Here
    }
    
}








