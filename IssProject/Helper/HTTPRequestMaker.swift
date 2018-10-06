//
//  HTTPRequestMaker.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

//MARK: HTTP Methods
enum HTTPRequestMethods : String {
    case Post = "Post"
    case Get = "Get"
}

//MARK:- HTTPRequestMaker
struct HTTPRequestMaker {
    
    //MARK:- doRequest
    // start a http request
    static func doRequest(_to serverAdresse : String ,_using httpMethod:String,_with parrams : [String:Any],completion: ((_ data:Data) -> Void)?,withError: ((_ error:Error) -> Void)?) {
        
        let parrams : [String:Any] = parrams
        var paramString =  (httpMethod == HTTPRequestMethods.Get.rawValue) ? "?" : ""
        // create the string parrams for the request
        parrams.map { (key,value) in
            paramString += "\(key)=\(value)&"
        }
        
        let url =  (httpMethod == HTTPRequestMethods.Get.rawValue) ? URL(string: "\(serverAdresse)\(paramString)") : URL(string: serverAdresse)
        
        guard url != nil && !httpMethod.isEmpty else {
            print("error parrams of the function check it")
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = httpMethod
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 8
        
        if httpMethod == HTTPRequestMethods.Post.rawValue {
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    withError?(error!)
                    return
                }
                guard data != nil else {
                    return
                }
                completion?(data!)
            }
        }
        task.resume()
    }
    
}
