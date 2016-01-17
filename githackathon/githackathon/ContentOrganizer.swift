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
        
        if !Cards.isEmpty {
            var card = Cards[0]
            QL4(card.twitter)
            if (card.twitter != nil) {
                ez.requestJSON("http://friend01k.herokuapp.com/api/twitter_watson/\(card.twitter!)", success: { (data) -> Void in

                    var JSON = data as! NSDictionary
                    for (k1,v1) in JSON["tree"] as! NSDictionary {
                        if k1 as! String == "children" {
                            for v2 in v1 as! NSArray {
                                for (k3,v3) in v2 as! NSDictionary {
                                    if k3 as! String == "children" {
                                        for v4 in v3 as! NSArray {
                                            if v4["category"] as! String == "personality" {
                                                for v5 in v4["children"] as! NSArray {
                                                    for v6 in v5["children"] as! NSArray {
                                                        var personality = CardData.Personality()
                                                        personality.name = v6["name"] as? String
                                                        personality.percentage = String(v6["percentage"] as! Float)
                                                        if (card.personalities == nil) {
                                                            card.personalities = [personality]
                                                        } else {
                                                            card.personalities!.append(personality)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }


                    }
                        
                    }, error: { (err) -> Void in
                        QL4(err)
                })
                
            }
        }

    }
    
    static func shouldCreateCard() {
        if VCOrganizer.LoadingFinished && VCOrganizer.MainVCHolder.currentCard == nil {
            VCOrganizer.MainVCHolder.createNewCard()
        }
    }
}






