//
//  CardData.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import Parse
import EZSwiftExtensions

protocol CardDataDelegate {
    func profileImageLoaded(image image: UIImage)
    func imageLoaded(image image: UIImage)
}

struct CardData {
    var objectId: String?
    var text: String?
    var media: UIImage?
    var mediaURL: String?
    var twitter: String?
    var authorName: String?
    var authorMedia: UIImage?
    var authorMediaURL: String?
    
    var delegate: CardDataDelegate?
    
    init() {
   
    }
    
    init(result: PFObject) {
        result.objectForKey("author")
        
        objectId = result["id"] as? String
        
        if let unwrappedText = result.objectForKey("text") as? String {
            text = unwrappedText
        }
        
        if let unwrappedTwitter = result.objectForKey("twitter") as? String {
            twitter = unwrappedTwitter
        }
        
        if let unwrappedMedia = result.objectForKey("media") as? String {
            if unwrappedMedia != "" {
                mediaURL = unwrappedMedia
                
//                ez.requestImage(mediaURL!, success: { (image) -> Void in
//                    self.media = image
//                    if self.delegate != nil {
//                        self.delegate!.imageLoaded(image: image!)
//                    }
//                })
            }
        }
        
        if let unwrappedAuthor = result.objectForKey("author") as? PFObject {
            if let unwrappedName = unwrappedAuthor.objectForKey("name") as? String {
                authorName = unwrappedName
            }
            
            if let unwrappedMedia = unwrappedAuthor.objectForKey("media") as? String {
                authorMediaURL = unwrappedMedia
                
//                ez.requestImage(authorMediaURL!, success: { (image) -> Void in
//                    self.authorMedia = image
//                    if self.delegate != nil {
//                        self.delegate!.profileImageLoaded(image: image!)
//                    }
//                })
            }
        }
    }

}