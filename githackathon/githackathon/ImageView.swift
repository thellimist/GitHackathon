//
//  ImageView.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 17/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ImageView: CardSubView {
    
    private struct Constants {
        static let HeightToResize: CGFloat = 300
        static let Padding: CGFloat = 5
    }
    
    var theImageView: UIImageView!
    
    //==========================================================================================================
    // MARK: - Setup
    //==========================================================================================================
    
    override func setupView(sender sender: MainCard) {
        super.setupView(sender: sender)
        //        backgroundColor = UIColor.purpleColor() test test
        
        let cardWidth = currentCardView.CardWidth
        if currentCardView.data.media != nil {
            QL2("Image is loaded")
            theImageView = UIImageView(x: 0, y: 0, image: currentCardView.data.media!, scaleToWidth: cardWidth)
        } else {
            QL2("Image is loading putting place holder")
            theImageView = UIImageView(x: 0, y: 0, imageName: "Placeholder", scaleToWidth: cardWidth)
        }

        addSubview(theImageView)
        
        let newFrame: CGRect = theImageView.frame
        self.frame = newFrame
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
    
    func updateImage(image image: UIImage) {
        theImageView.image = image

//        let heightRatio = image.size.height /
//        let newHeigth = image.size.height / heightRatio
//        let newWidth = image.size.width / heightRatio
//        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
        
        frame = theImageView.frame
        currentCardView.adjustViewSizes(animated: false, resize: true)
    }
    
}


