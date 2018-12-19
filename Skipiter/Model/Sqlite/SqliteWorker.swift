//
//  SqliteWorker.swift
//  Skipiter
//
//  Created by Admin on 12/18/18.
//  Copyright © 2018 Home. All rights reserved.
//
import SQLite3
import Foundation

class SqliteWorker {
    private var db: OpaquePointer? = nil
    private var dbName: String!
    public var isDBHealthy: Bool = false
    
    init() {
        dbName = "skipiterDatabase.sqlite"
        if OpenDatabase() {
            self.isDBHealthy = true
            createTable()
        }
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    func insert(user: User) {
        if isDBHealthy {
            if let insertStatement = SqlPreparationOK(db, sqlCommand: .inserUserCommand) {
                BindAttributes(ofUser: user, forStatement: insertStatement)
                SqliteStep(db, withStatement: insertStatement, successMessage: "Successfully inserted \(user.userName).", failMessage: "Could not insert \(user.userName)")
                sqlite3_finalize(insertStatement)
            }
        }
    }
    
    func insert(users: [User]) {
        if isDBHealthy {
            if let insertStatement = SqlPreparationOK(db, sqlCommand: .inserUserCommand) {
                for user in users {
                    BindAttributes(ofUser: user, forStatement: insertStatement)
                    SqliteStep(db, withStatement: insertStatement, successMessage: "Successfully inserted \(user.userName)", failMessage: "Could not insert \(user.userName)")
                    sqlite3_reset(insertStatement)
                }
                sqlite3_finalize(insertStatement)
            }
        }
    }
    
    func SelectUsers() -> [User]{
        var users = [User]()
        if isDBHealthy {
            if let queryStatement = SqlPreparationOK(db, sqlCommand: .selectUsersCommand) {
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    users.append(CreateUser(fromResult: queryStatement))
                }
                sqlite3_finalize(queryStatement)
            }
        }
        return users
    }
    
    func SelectUser(withUserName: String, andUserPassword: String) -> User?{
        var returnUser: User?
        if isDBHealthy {
            if let selectStatement = SqlPreparationOK(db, sqlCommand: .selectUserWithUserNameAndPasswordCommand) {
                sqlite3_bind_text(selectStatement, 1, NSString(string: withUserName).utf8String, -1, nil)
                sqlite3_bind_text(selectStatement, 2, NSString(string: andUserPassword).utf8String, -1, nil)
                if sqlite3_step(selectStatement) == SQLITE_ROW {
                    returnUser = CreateUser(fromResult: selectStatement)
                }
                sqlite3_finalize(selectStatement)
            }
        }
        return returnUser
    }
    
    func IsUserUnique(withUserName: String) -> Bool{
        if isDBHealthy {
            if let selectStatement = SqlPreparationOK(db, sqlCommand: .selectUserWithUserNameCommand) {
                sqlite3_bind_text(selectStatement, 1, NSString(string: withUserName).utf8String, -1, nil)
                if sqlite3_step(selectStatement) == SQLITE_ROW {
                    let returnedRows = sqlite3_column_int(selectStatement, 0)
                    if returnedRows == 0 {
                        return true
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        return false
    }
    
    
    
    func UpdatePassword(ofUser: User, withNewPassword: String) {
        if isDBHealthy {
            if let updateStatement = SqlPreparationOK(db, sqlCommand: .updateUserPasswordCommand) {
                sqlite3_bind_text(updateStatement, 1, NSString(string: withNewPassword).utf8String, -1, nil)
                sqlite3_bind_text(updateStatement, 2, NSString(string: ofUser.userName).utf8String, -1, nil)
                
                SqliteStep(db, withStatement: updateStatement, successMessage: "Successfully updated \(ofUser.userName)", failMessage: "Could not update \(ofUser.userName)")
                sqlite3_finalize(updateStatement)
            }
        }
    }
    
    func deleteUserWithName(userName: String){
        if isDBHealthy {
            if let deleteStatement = SqlPreparationOK(db, sqlCommand: .deleteUserWithUserNameCommand) {
                sqlite3_bind_text(deleteStatement, 1, NSString(string: userName).utf8String, -1, nil)
                
                SqliteStep(db, withStatement: deleteStatement, successMessage: "Successfully deleted \(userName).", failMessage: "Could not delete \(userName)")
                sqlite3_finalize(deleteStatement)
            }
        }
    }
    
    func deleteAllUsers() {
        if isDBHealthy {
            if let deleteStatement = SqlPreparationOK(db, sqlCommand: .deleteAllUsersCommand) {
                SqliteStep(db, withStatement: deleteStatement, successMessage: "Successfully deleted all users.", failMessage: "Could not delete all users")
                sqlite3_finalize(deleteStatement)
            }
        }
    }
    
    public func createTable() {
        if isDBHealthy {
            if let createTableStatement = SqlPreparationOK(db, sqlCommand: .createCommand) {
                SqliteStep(db, withStatement: createTableStatement, successMessage: "Users table created.", failMessage: "Users table could not be created")
                sqlite3_finalize(createTableStatement)
            } 
        }
    }
    
    public func OpenDatabase() -> Bool {
        let dbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbName)
        
        if sqlite3_open(dbPath.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
            return true
        } else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Unable to open database: \(errorMessage)")
            return false
        }
    }
    
    
}
