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
        cardData.text = "This guy drank 5 giliasdgasdfn of beer."
        cardData.name = "JJ. Abrahams"
        cardData.image = UIImage(named: "TestImage")
        
        
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
            newCard.createView(sender: self, border: false, shadow: false, check: true, cross: true)
            
            setupCard(card: newCard, canSendLeft: true, canSendRight: true, enableMovement: true)
            ContentOrganizer.CardsFinished = false
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








