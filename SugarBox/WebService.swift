//
//  WebService.swift
//  SugarBox
//
//  Created by khim singh on 16/05/17.
//  Copyright © 2017 eSoft. All rights reserved.
//

import Foundation
import Alamofire
class WebService{
    class func hitGetService (urlToPass url:URL, parameterToPass parameter:Any?=nil,responceBlock:@escaping (Any?)->Void){
        
        Alamofire.request(url, method: .get, parameters: parameter as? Dictionary<String,Any>, encoding: URLEncoding.methodDependent, headers:nil)
            .responseJSON(completionHandler:{ response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.error)
                print(response.result.value as Any)
                let jsonData = try! JSONSerialization.data(withJSONObject: response.result.value, options: JSONSerialization.WritingOptions.prettyPrinted)
                responceBlock(jsonData)
                
                
            })    }
    class func hitPostService (urlToPass url:URL!, parameterToPass parameter:Any?=nil,responceBlock:@escaping (Any?)->Void){
        Alamofire.request(url, method: .post, parameters: parameter as! Dictionary<String,Any>, encoding: URLEncoding.methodDependent, headers:nil)
            .responseJSON(completionHandler:{ response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)
                print(response.result.error)
                responceBlock(response.result.value)
                
                
            })
    }
}
