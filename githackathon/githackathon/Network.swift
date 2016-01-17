//
//  Network.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import Alamofire
import UIKit

struct IBMWatson {
    
    enum Router: URLRequestConvertible {
        static let baseURLString = "https://api.instagram.com"
        static let clientID = "31aeb778aa24439fafcf32bf22643b16"
        static let redirectURI = "http://www.example.com/"
        static let clientSecret = "53324118a75c433b92bb135a9e1b4b8f"
        
        case Mood(String)
        
        var URLRequest: NSMutableURLRequest {
            let result: (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                case .Mood(let accessToken):
                    let params = ["access_token": accessToken]
                    let pathString = "/v1/media/popular"
                    return (pathString, params)
                }
            }()
            
            let BaeseURL = NSURL(string: Router.baseURLString)!
            let URLRequest = NSURLRequest(URL: BaeseURL.URLByAppendingPathComponent(result.path))
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: result.parameters).0
        }
        
    }
}
