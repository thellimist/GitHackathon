//
//  Network.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

//import Alamofire
//import UIKit
import Parse

class Network {
    static func GetData() {
        let query = PFQuery(className: "githack")
        query.includeKey("author")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        let cardData = CardData(result: object)
                        ContentOrganizer.Cards.append(cardData)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    ContentOrganizer.shouldCreateCard()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
}


//
//struct Parse {
//    
//    enum Router: URLRequestConvertible {
//        static let baseURLString = "https://api.parse.com"
//
//        case GetData(String)
//        
//        var URLRequest: NSMutableURLRequest {
//            let result: (path: String, parameters: [String: AnyObject]?) = {
//                switch self {
//                case .GetData(let accessToken):
//                    let params = ["access_token": accessToken]
//                    let pathString = "/v1/media/popular"
//                    return (pathString, params)
//                }
//            }()
//            
//            let BaeseURL = NSURL(string: Router.baseURLString)!
//            let URLRequest = NSURLRequest(URL: BaeseURL.URLByAppendingPathComponent(result.path))
//            let encoding = Alamofire.ParameterEncoding.URL
//            return encoding.encode(URLRequest, parameters: result.parameters).0
//        }
//        
//    }
//}
