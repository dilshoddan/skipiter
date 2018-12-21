//
//  SqliteWorker.swift
//  Skipiter
//
//  Created by Admin on 12/18/18.
//  Copyright © 2018 Home. All rights reserved.
//
import UIKit
import SQLite3
import Foundation

class SqliteWorker {
    private var db: OpaquePointer? = nil
    private var dbName: String!
    private var fileWorker: FileWorker!
    public var isDBHealthy: Bool = false
    
    init() {
        dbName = "skipiterDatabase.sqlite"
        fileWorker = FileWorker()
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
                    do{
                        try users.append(CreateUser(fromResult: queryStatement))
                    }
                    catch {
                        print("Select users")
                    }
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
                    do {
                        try returnUser = CreateUser(fromResult: selectStatement)
                    }
                    catch {
                        print("SelectUser sqlite worker")
                    }
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
    
    
    
    func UpdateUserPassword(ofUser: User, withNewPassword: String) {
        if isDBHealthy {
            if let updateStatement = SqlPreparationOK(db, sqlCommand: .updateUserPasswordCommand) {
                sqlite3_bind_text(updateStatement, 1, NSString(string: withNewPassword).utf8String, -1, nil)
                sqlite3_bind_text(updateStatement, 2, NSString(string: ofUser.userName).utf8String, -1, nil)
                
                SqliteStep(db, withStatement: updateStatement, successMessage: "Successfully updated \(ofUser.userName)", failMessage: "Could not update \(ofUser.userName)")
                sqlite3_finalize(updateStatement)
            }
        }
    }
    
    func UpdateUserProfileImage(ofUser: User, imageName: String) throws {
        if isDBHealthy {
            if let updateStatement = SqlPreparationOK(db, sqlCommand: .updateUserProfileImageCommand) {
                sqlite3_bind_text(updateStatement, 1, NSString(string: imageName).utf8String, -1, nil)
                sqlite3_bind_text(updateStatement, 2, NSString(string: ofUser.userName).utf8String, -1, nil)
                SqliteStep(db, withStatement: updateStatement, successMessage: "Successfully updated \(ofUser.userName)", failMessage: "Could not update \(ofUser.userName)")
                sqlite3_finalize(updateStatement)
            }
        }
    }
    
    
    func UpdateUserProfileBanner(ofUser: User, imageName: String) throws {
        if isDBHealthy {
            if let updateStatement = SqlPreparationOK(db, sqlCommand: .updateUserProfileBannerCommand) {
                sqlite3_bind_text(updateStatement, 1, NSString(string: imageName).utf8String, -1, nil)
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
    
    func CreateUser(fromResult: OpaquePointer?) throws -> User {
        let user = User(firstname: String(cString: (sqlite3_column_text(fromResult, 0))!),
                        lastName: String(cString: (sqlite3_column_text(fromResult, 1))!),
                        email: String(cString: (sqlite3_column_text(fromResult, 2))!),
                        userName: String(cString: (sqlite3_column_text(fromResult, 3))!),
                        userPassword: String(cString: (sqlite3_column_text(fromResult, 4))!)
        )
        
        let profileImageName = String(cString: (sqlite3_column_text(fromResult, 5))!)
        let profileImage = fileWorker.getImageFromDocumentDirectory(imageName: profileImageName)
        if let profileImage = profileImage {
            user.profileImage = profileImage
        }
        
        let profileBannerName = String(cString: (sqlite3_column_text(fromResult, 5))!)
        let profileBanner = fileWorker.getImageFromDocumentDirectory(imageName: profileBannerName)
        if let profileBanner = profileBanner {
            user.profileBanner = profileBanner
        }
        
//        let profileImageCount = Int(sqlite3_column_bytes(fromResult, 5))
//        let profileImage = sqlite3_column_blob(fromResult, 5)
//        if profileImageCount > 0, let profileImage = profileImage {
//            let userProfileImage = UIImage(data: Data(bytes: profileImage, count: profileImageCount))
//            if let userProfileImage = userProfileImage {
//                user.profileImage = userProfileImage
//            }
//        }
//
//        let profileBannerCount = Int(sqlite3_column_bytes(fromResult, 5))
//        let profileBanner = sqlite3_column_blob(fromResult, 5)
//        if profileBannerCount > 0, let profileBanner = profileBanner {
//            let userProfileBanner = UIImage(data: Data(bytes: profileBanner, count: profileBannerCount))
//            if let userProfileBanner = userProfileBanner {
//                user.profileBanner = userProfileBanner
//            }
//        }
        
        
        return user
        
    }
    
    
    
    
}

//FOR STORING IMAGE AS A BLOB

//guard userImageData.withUnsafeBytes({ (bytes: UnsafePointer<UInt8>) -> Int32 in
//    sqlite3_bind_blob(updateStatement, 1, bytes, Int32(userImageData.count), nil)
//}) == SQLITE_OK else {
//    var errorMessage: String { return String(cString: sqlite3_errmsg(db)) }
//    throw SQLiteError.bind(message: errorMessage)
//}
