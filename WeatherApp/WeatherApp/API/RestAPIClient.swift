//
//  RestAPIClient.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/23/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIClient: NSObject {
    private var baseURL: String
    static let sharedInstance = RestAPIClient(serverBaseURL: Constants.baseURLString)
    
    init(serverBaseURL: String) {
        self.baseURL = serverBaseURL
        super.init()
    }
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func request(verb: String, method: String, body:Dictionary<String, Any>?, completion:@escaping (Error?, NSDictionary?)->Void) -> Void {
        switch verb {
        case "get":
            self.requestGet(method: method, body: body, completion: { (error, data) in
                completion(error, data)
            })
        default:
            break
        }
    }
    
    
    private func requestGet(method: String, body:Dictionary<String, Any>?, completion: @escaping (Error?, NSDictionary?)->Void) -> Void {
        let fullURL = URL(string: self.fullApiEndPoint(method: method))
        Alamofire.request(fullURL!,
                          method: .get,
                          parameters: body,
                          encoding:  URLEncoding.default,
                          headers: nil).validate().responseJSON { (response) in
                            
                            if response.response?.statusCode == 200 {
                                if let result = response.result.value {
                                    let jsonData = result as! NSDictionary
                                    completion(nil, jsonData)
                                } else {
                                    completion(nil, nil)
                                }
                                
                            } else {
                                completion(response.error, nil)
                            }
            
        }
        
    }
    
    private func fullApiEndPoint(method:String) -> String {
        return String (format: "%@/%@", self.baseURL, method)
    }

    

}
