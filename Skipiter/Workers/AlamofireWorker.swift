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
    
    public static func registerUser(with email: String, and password: String, _ registerVC: RegisterViewController){
        var registered: Bool = false
        
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
                        downloadGroup.leave()
                }
                downloadGroup.wait()
                debugPrint(request)
                DispatchQueue.main.async {
                    
                    
                    if registered {
                        registerVC.navigationController?.popToRootViewController(animated: true)
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Cannot register", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Cannot register")
                        }))
                        registerVC.present(alertController, animated: true, completion: nil)
                    }
                    registerVC.registerView.activityIndicator.stopAnimating()
                    registerVC.registerView.activityIndicator.isHidden = true
                    registerVC.registerView.activityIndicator.removeFromSuperview()
                }
                
            }
        }
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
                    "name": email,
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
                    loginVC.loginView.activityIndicator.stopAnimating()
                    loginVC.loginView.activityIndicator.isHidden = true
                    loginVC.loginView.activityIndicator.removeFromSuperview()
                }
                debugPrint(request)
            }
            
        }
    }
    
    public static func ListAllSkips(_ skipsVC: SkipsViewController){
        var succeeded: Bool = false
        var skips = [AlamofireWorker.listAllSkipsJsonData] ()
        DispatchQueue.global(qos: .userInitiated).async {
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            
            if let sessionManager = sessionManager {
                
                let request = sessionManager.request("https://skipiter.vapor.cloud/listAllSkips", encoding: URLEncoding.httpBody)
                    .responseJSON { response in
                        debugPrint(response)
                        if response.result.isSuccess {
                            if let data = response.data {
                                let decoder = JSONDecoder()
                                do {
                                    let responseData = try decoder.decode([listAllSkipsJsonData].self, from: data)
                                    succeeded = true
                                    skips = responseData
                                    
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
                    
                    
                    if succeeded {
                        skipsVC.skips = skips
                        skipsVC.skipsView.skipsTable.reloadData()
                        skipsVC.skipsView.skipsTable.estimatedRowHeight = 100
                        skipsVC.skipsView.skipsTable.rowHeight = UITableView.automaticDimension
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Cannot connect to Internet", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Cannot connect to Internet")
                        }))
                        skipsVC.present(alertController, animated: true, completion: nil)
                    }
                    skipsVC.skipsView.activityIndicator.stopAnimating()
                    skipsVC.skipsView.activityIndicator.isHidden = true
                    skipsVC.skipsView.activityIndicator.removeFromSuperview()
                }
                debugPrint(request)
            }
            
        }
    }
    
    public static func ListUserSkips(_ profileVC: ProfileViewController){
        var succeeded: Bool = false
        var skips = [AlamofireWorker.listAllSkipsJsonData] ()
        DispatchQueue.global(qos: .userInitiated).async {
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            
            if let sessionManager = sessionManager {
                
                let request = sessionManager.request("https://skipiter.vapor.cloud/listSkips", encoding: URLEncoding.httpBody)
                    .responseJSON { response in
                        debugPrint(response)
                        if response.result.isSuccess {
                            if let data = response.data {
                                let decoder = JSONDecoder()
                                do {
                                    let responseData = try decoder.decode([listAllSkipsJsonData].self, from: data)
                                    succeeded = true
                                    skips = responseData
                                    
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
                    
                    
                    if succeeded {
                        profileVC.skips = skips
                        profileVC.profileView.skipsTable.reloadData()
                        profileVC.profileView.skipsTable.estimatedRowHeight = 100
                        profileVC.profileView.skipsTable.rowHeight = UITableView.automaticDimension
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Cannot connect to Internet", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Cannot connect to Internet")
                        }))
                        profileVC.present(alertController, animated: true, completion: nil)
                    }
                    profileVC.profileView.activityIndicator.stopAnimating()
                    profileVC.profileView.activityIndicator.isHidden = true
                    profileVC.profileView.activityIndicator.removeFromSuperview()
                }
                debugPrint(request)
            }
            
        }
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
