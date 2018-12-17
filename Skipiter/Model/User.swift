//
//  User.swift
//  Skipiter
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Home. All rights reserved.
//

class User {
    public var firstName: String
    public var lastName: String
    public var email: String
    public var userName: String
    public var userPassword: String
    
    init(firstname: String, lastName: String, email: String, userName: String, userPassword: String){
        self.firstName = firstname
        self.lastName = lastName
        self.email = email
        self.userName = userName
        self.userPassword = userPassword
    }
}
