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

var GlobalCardId = 0

struct CardData {
    var id: Int?
    var objectId: String?
    var text: String?
    var media: UIImage?
    var mediaURL: String?
    var twitter: String?
    var authorName: String?
    var authorMedia: UIImage?
    var authorMediaURL: String?
    var personalities: [Personality]?
    
    struct Personality {
        var name: String?
        var percentage: String?
    }
    
    var delegate: CardDataDelegate?
    
    init() {

    }
    
    init(result: PFObject) {
        result.objectForKey("author")
        
        objectId = result["id"] as? String
        id = GlobalCardId++
        
        if let unwrappedText = result.objectForKey("text") as? String {
            text = unwrappedText
        }
        
        if let unwrappedMedia = result.objectForKey("media") as? String {
            if unwrappedMedia != "" {
                mediaURL = unwrappedMedia
            }
        }
        
        if let unwrappedAuthor = result.objectForKey("author") as? PFObject {
            if let unwrappedName = unwrappedAuthor.objectForKey("name") as? String {
                authorName = unwrappedName
            }
            
            if let unwrappedMedia = unwrappedAuthor.objectForKey("media") as? String {
                authorMediaURL = unwrappedMedia
            }
            
            if let unwrappedTwitter = unwrappedAuthor.objectForKey("twitter") as? String {
                twitter = unwrappedTwitter
            }
        }
    }

}