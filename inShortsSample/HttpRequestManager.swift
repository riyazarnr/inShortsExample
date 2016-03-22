//
//  HttpRequestManager.swift
//  inShortsSample
//
//  Created by riyaz shaik on 22/03/16.
//  Copyright © 2016 riyaz. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class HttpRequestManager {

    static let SharedInstance = HttpRequestManager()

    
    func simpleGetMethod(endpointurl:String,responseData:(data:AnyObject?, error:NSError?) -> Void){
        
        Alamofire.request(.GET,endpointurl,encoding:.JSON).responseJSON(completionHandler: { (response) -> Void in
            
            switch response.result{
            case .Success:
                responseData(data: response.data, error: nil)
            case .Failure(let aerror):
                
                responseData(data:nil, error:aerror)
            }
            
            
            })
    }
    
    
    func getRequest(endpointurl:String,parameters:[String: AnyObject],responseData:(data:AnyObject?, error:NSError?) -> Void){
        
        Alamofire.request(.GET, endpointurl, parameters: parameters, encoding: .JSON).responseJSON { (response) -> Void in
            
            switch response.result{
            case .Success:
                responseData(data: response.data, error: nil)
            case .Failure(let aerror):
                
                responseData(data:nil, error:aerror)
            }
            
        }
        
    }
    
}
