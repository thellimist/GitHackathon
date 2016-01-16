//
//  CardSubView.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit

class CardSubView: UIView {
    
    var currentCardView: MainCard!
    
    func setupView(sender sender: MainCard) {
        currentCardView = sender
    }
    
}
