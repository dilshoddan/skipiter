//
//  User.swift
//  Skipiter
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Home. All rights reserved.
//
import UIKit

class User {
    public var userName: String
    public var email: String
    public var userPassword: String
    
    init(userName: String, email: String, userPassword: String){
        self.userName = userName
        self.email = email
        self.userPassword = userPassword
    }
}
