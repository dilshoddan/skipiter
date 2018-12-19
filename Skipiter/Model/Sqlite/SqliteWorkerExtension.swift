//
//  SqliteWorkerExtension.swift
//  Skipiter
//
//  Created by Admin on 12/19/18.
//  Copyright © 2018 Home. All rights reserved.
//
import Foundation
import SQLite3

extension SqliteWorker {
    
    
    func SqliteStep(_ db: OpaquePointer?, withStatement: OpaquePointer?, successMessage: String, failMessage: String){
        if let withStatement = withStatement {
            if sqlite3_step(withStatement) == SQLITE_DONE {
                print(successMessage)
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("\(failMessage): \(errorMessage)")
            }
        }
    }
    
    func SqlPreparationOK(_ db:OpaquePointer?, sqlCommand: String) -> OpaquePointer? {
        var sqlStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sqlCommand, -1, &sqlStatement, nil) == SQLITE_OK {
            return sqlStatement
        }
        else {
            return nil
        }
    }
    
    func BindAttributes(ofUser: User, forStatement: OpaquePointer?) {
        if let forStatement = forStatement {
            sqlite3_bind_text(forStatement, 1, NSString(string: ofUser.firstName).utf8String, -1, nil)
            sqlite3_bind_text(forStatement, 2, NSString(string: ofUser.lastName).utf8String, -1, nil)
            sqlite3_bind_text(forStatement, 3, NSString(string: ofUser.email).utf8String, -1, nil)
            sqlite3_bind_text(forStatement, 4, NSString(string: ofUser.userName).utf8String, -1, nil)
            sqlite3_bind_text(forStatement, 5, NSString(string: ofUser.userPassword).utf8String, -1, nil)
        }
    }
    
    func CreateUser(fromResult: OpaquePointer?) -> User {
        return User(firstname: String(cString: (sqlite3_column_text(fromResult, 0))!),
                    lastName: String(cString: (sqlite3_column_text(fromResult, 1))!),
                    email: String(cString: (sqlite3_column_text(fromResult, 2))!),
                    userName: String(cString: (sqlite3_column_text(fromResult, 3))!),
                    userPassword: String(cString: (sqlite3_column_text(fromResult, 4))!)
        )
        
    }
    
}
