//
//  ContentOrganizer.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import EZSwiftExtensions
import UIKit

struct ContentOrganizer {
    static var LastCard: CardData?
    static var Cards = [CardData]()
    static var CardsFinished = true
    
    static func nextCard() {
        
        if Cards.count > 0 {
            LastCard = Cards.first!
            Cards.removeAtIndex(0)
        }
        
        ContentOrganizer.shouldLoadData()
    }
    
    static func resetCardsInMemory() {
        if !self.CardsFinished {
            QL2("Resetting old cards in memory")
            VCOrganizer.MainVCHolder.resetCard(card: VCOrganizer.MainVCHolder.currentCard!)
            VCOrganizer.MainVCHolder.updateScrollViewContentSize(newheight: 0)
            Cards.removeAll(keepCapacity: true)
            CardsFinished = true
        }
    }
    
    static func shouldLoadData() {
        // Maybe pagination? 
    }
    
    static func shouldCreateCard() {
        if VCOrganizer.LoadingFinished && VCOrganizer.MainVCHolder.currentCard == nil {
            VCOrganizer.MainVCHolder.createNewCard()
        }
    }
}






