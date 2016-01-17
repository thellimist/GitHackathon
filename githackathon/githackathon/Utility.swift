//
//  Utility.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import Foundation
import EZSwiftExtensions

struct Utility {
    
    static let ThemeFontName = "SFCompactDisplay-Regular"
    
    static let TeamRedColor = UIColor(r: 207, g: 32, b: 40)
    static let TeamBlueColor = UIColor(r: 0, g: 41, b: 92)
    
    static func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    static func getValueForCurrentScreenSize(iphone4 iphone4: Int, iphone5: Int, iphone6: Int, iphone6p: Int, ipad: Int) -> Int {
        if ez.screenWidth == 320 && ez.screenHeight == 480 {  //320 480 iphone4
            return iphone4
        } else if ez.screenWidth == 320 && ez.screenHeight == 568 {  //320 568 iphone5
            return iphone5
        } else if ez.screenWidth == 375 && ez.screenHeight == 667 {  //375 667 iphone6
            return iphone6
        } else if ez.screenWidth == 414 && ez.screenHeight == 736 {  //414 736 iphone6p
            return iphone6p
        } else if ez.screenWidth == 768 && ez.screenHeight == 1024 {  //768 1024 ipad
            return ipad
        } else {
            return iphone4
        }
    }
}