//
//  CardData.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import UIKit
import Parse

struct CardData {
    var objectId: String?
    var text: String?
    var media: UIImage?
    var mediaURL: String?
    var twitter: String?
    var authorName: String?
    var authorMedia: UIImage?
    var authorMediaURL: String?
    
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
            mediaURL = unwrappedMedia
        }
        
        if let unwrappedAuthor = result.objectForKey("author") as? PFObject {
            if let unwrappedName = unwrappedAuthor.objectForKey("name") as? String {
                authorName = unwrappedName
            }
            if let unwrappedMedia = unwrappedAuthor.objectForKey("media") as? String {
                authorMediaURL = unwrappedMedia
            }
        }
    }

}