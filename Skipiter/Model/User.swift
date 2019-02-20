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
    public var id: Int?
    
    init(userName: String, email: String){
        self.userName = userName
        self.email = email
    }
}
