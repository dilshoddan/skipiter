//
//  AlamofireWorker.swift
//  Skipiter
//
//  Created by Admin on 1/15/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Alamofire
import PromiseKit

class AlamofireWorker {
    
    public static var sessionManagerWithBearer: Alamofire.SessionManager?
    public static var sessionManager: Alamofire.SessionManager?
    
    
    
    public static func registerUser(with userName: String, and email: String, and password: String) -> Promise<Bool> {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters = [
            "name": userName,
            "email": email,
            "password": password
        ]
        
        return Promise { seal in
            Alamofire.request("https://skipiter.vapor.cloud/register", method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseJSON  { response in
                    
                    switch response.result {
                    case .success(let json):
                        
                        guard let json = json  as? [String: Any], let id = json["id"] as? Int else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        
                        debugPrint("New user's id is \(id)")
                        
                        seal.fulfill(true)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
    
    
    
    public static func loginPromise(with userName: String, and password: String) -> Promise<Bool> {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters = [
            "name": userName,
            "password": password
        ]
        
        return Promise { seal in
            Alamofire.request("https://skipiter.vapor.cloud/login", method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseJSON  { response in
                    
                    switch response.result {
                    case .success(let json):
                        
                        guard let json = json  as? [String: Any], let token = json["token"] as? String else {
                            return seal.fulfill(false)
                                //seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        
                        var headers = Alamofire.SessionManager.defaultHTTPHeaders
                        headers["Authorization"] = "Bearer \(token)"
                        var configuration = URLSessionConfiguration.default
                        configuration.httpAdditionalHeaders = headers
                        self.sessionManagerWithBearer = Alamofire.SessionManager(configuration: configuration)
                        
                        headers["Accept"] = "application/json"
                        configuration = URLSessionConfiguration.default
                        configuration.httpAdditionalHeaders = headers
                        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
                        
                        seal.fulfill(true)
                    case .failure(let error):
                        seal.reject(error)
                    }
                    
            }
        }
    }
    

    public static func ComposeSkip(text: String) -> Promise<Bool> {
//        let headers: HTTPHeaders = [
//            "Accept": "application/json"
//        ]
        
        let parameters = [
            "text": text
        ]
        
        return Promise { seal in
            if let sessionManagerWithBearer = sessionManagerWithBearer {
                
                sessionManagerWithBearer.request("https://skipiter.vapor.cloud/skip", method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.httpBody)
                    .responseJSON { response in
                        
                        switch response.result {
                        case .success(let json):
                            
                            guard let arrayOfDictionary = json  as? [String: Any], let _ = arrayOfDictionary["text"] as? String  else {
                                return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                            }
                            
                            seal.fulfill(true)
                        case .failure(let error):
                            seal.reject(error)
                        }
                }
                
                
            }
            
        }
        
    }
    
    public static func ListAllSkips() -> Promise<([[String: Any]], Bool)> {
       
        return Promise { seal in
            if let sessionManager = sessionManager {
                
                sessionManager.request("https://skipiter.vapor.cloud/listAllSkips", encoding: URLEncoding.httpBody)
                    .responseJSON { response in
                    
                    switch response.result {
                    case .success(let json):
                        
                        guard let arrayOfDictionary = json  as? [[String: Any]] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        
                        seal.fulfill((arrayOfDictionary, true))
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
                    
            
            }
        
        }
    
    }
    
    public static func ListUserSkips() -> Promise<([[String: Any]], Bool)> {
        
        return Promise { seal in
            if let sessionManager = sessionManager {
                
                sessionManager.request("https://skipiter.vapor.cloud/listSkips", encoding: URLEncoding.httpBody)
                    .responseJSON { response in
                        
                        switch response.result {
                        case .success(let json):
                            
                            guard let arrayOfDictionary = json  as? [[String: Any]] else {
                                return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                            }
                            
                            seal.fulfill((arrayOfDictionary, true))
                        case .failure(let error):
                            seal.reject(error)
                        }
                }
                
                
            }
            
        }
        
    }
    
    
    public static func ConvertDictionaryToSkips(_ arrayOfDictionaries: [[String: Any]]) -> [AlamofireWorker.listAllSkipsJsonData]{
        var skips = [AlamofireWorker.listAllSkipsJsonData] ()
        for skip in arrayOfDictionaries {
            guard
                let date = skip["date"] as? String,
                let text = skip["text"] as? String,
                let userName = skip["userName"] as? String
                else {
                    continue
                    
            }
            skips.append(AlamofireWorker.listAllSkipsJsonData(date: date,
                                                              text: text,
                                                              userName: userName))
        }
        return skips
    }
    
    
    
    
    struct registerJsonData: Codable {
        let id: Int
        let name: String
        let email: String
    }
    
    struct loginJsonData: Codable {
        let id: Int
        let token: String
    }
    
    struct listAllSkipsJsonData: Codable {
        let date: String
        let text: String
        let userName: String
    }
    
    
}
