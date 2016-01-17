//
//  Network.swift
//  githackathon
//
//  Created by Furkan Yilmaz on 16/01/16.
//  Copyright © 2016 Furkan Yilmaz. All rights reserved.
//

import Alamofire
import UIKit

struct Parse {
    
    enum Router: URLRequestConvertible {
        static let baseURLString = "https://api.parse.com"

        case GetData(String)
        
        var URLRequest: NSMutableURLRequest {
            let result: (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                case .GetData(let accessToken):
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
