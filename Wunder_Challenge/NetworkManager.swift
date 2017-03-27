//
//  NetworkManager.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkSuccessClosure = (Any?) -> Void
typealias NetworkErrorClosure = (Error) -> Void

class NetworkManager {
    
    class func performRequestWithPath(path: String, requestMethod: Alamofire.HTTPMethod, parameters: [String : AnyObject]?, headers: [String : String]?, success:@escaping NetworkSuccessClosure, failure:  @escaping NetworkErrorClosure) {
        
        let url = Network.baseURL + path
        Alamofire.request(url, method: requestMethod, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success(_):
                    success(response.result.value)
                case .failure(let error):
                    failure(error)
                }
        }
    }
}
