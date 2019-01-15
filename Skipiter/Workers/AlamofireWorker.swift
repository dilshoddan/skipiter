//
//  AlamofireWorker.swift
//  Skipiter
//
//  Created by Admin on 1/15/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Alamofire

class AlamofireWorker {
    
    public static var sessionManagerWithBearer: Alamofire.SessionManager?
    public static var sessionManager: Alamofire.SessionManager?
    
    public static func registerUser(with email: String, and password: String) -> Bool{
        var registered: Bool = false
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if !email.isEmpty, !password.isEmpty {
            let parameters = [
                "email": email,
                "password": password
            ]
            
            let request = Alamofire.request("https://skipiter.vapor.cloud/register", method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseJSON { response in
                    debugPrint(response)
                    if response.result.isSuccess {
                        if let data = response.data {
                            let decoder = JSONDecoder()
                            do {
                                let responseData = try decoder.decode(registerJsonData.self, from: data)
                                debugPrint("New user's id is \(responseData.id)")
                                registered = true
                            }
                            catch {
                                debugPrint("Register result data cannot be decoded from JSON")
                            }
                        }
                    }
                    else {
                        debugPrint("Register failed")
                    }
            }
            debugPrint(request)
        }
        return registered
    }
    
    
    public static func login(with email: String, and password: String, _ loginVC: LoginViewController){
        var loggedIn: Bool = false
        DispatchQueue.global(qos: .userInitiated).async {
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            let headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            
            if !email.isEmpty, !password.isEmpty {
                let parameters = [
                    "email": email,
                    "password": password
                ]
                
                let request = Alamofire.request("https://skipiter.vapor.cloud/login", method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                    .responseJSON { response in
                        debugPrint(response)
                        if response.result.isSuccess {
                            if let data = response.data {
                                let decoder = JSONDecoder()
                                do {
                                    let responseData = try decoder.decode(loginJsonData.self, from: data)
                                    
                                    var headers = Alamofire.SessionManager.defaultHTTPHeaders
                                    headers["Authorization"] = "Bearer \(responseData.token)"
                                    var configuration = URLSessionConfiguration.default
                                    configuration.httpAdditionalHeaders = headers
                                    self.sessionManagerWithBearer = Alamofire.SessionManager(configuration: configuration)
                                    
                                    headers["Accept"] = "application/json"
                                    configuration = URLSessionConfiguration.default
                                    configuration.httpAdditionalHeaders = headers
                                    self.sessionManager = Alamofire.SessionManager(configuration: configuration)
                                    
                                    loggedIn = true
                                    debugPrint("Logged In")
                                    
                                }
                                catch {
                                    debugPrint("Register result data cannot be decoded from JSON")
                                }
                            }
                        }
                        else {
                            debugPrint("Register failed")
                        }
                        downloadGroup.leave()
                }
                downloadGroup.wait()
                DispatchQueue.main.async {
                    loginVC.loginView.activityIndicator.stopAnimating()
                    loginVC.loginView.activityIndicator.isHidden = true
                    loginVC.loginView.activityIndicator.removeFromSuperview()
                    
                    if loggedIn {
                        let skipsVC = SkipsViewController()
                        loginVC.navigationController?.pushViewController(skipsVC, animated: true)
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "User name and password do not match", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("User name and password do not match")
                        }))
                        loginVC.present(alertController, animated: true, completion: nil)
                        loginVC.loginView.userName.text = ""
                        loginVC.loginView.userPassword.text = ""
                    }
                }
                debugPrint(request)
            }
            
        }
    }
    
    
    
    struct registerJsonData: Codable {
        let id: Int
        let email: String
    }
    
    struct loginJsonData: Codable {
        let id: Int
        let token: String
    }
    
}
