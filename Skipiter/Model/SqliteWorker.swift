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
    init() {
        db = openDatabase()
        dbName = "skipiterDatabase.sqlite"
    }
    
    func insert(user: User) {
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, inserUserCommand, -1, &insertStatement, nil) == SQLITE_OK {
            BindAttributes(ofUser: user, forStatement: insertStatement)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func insert(users: [User]) {
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, inserUserCommand, -1, &insertStatement, nil) == SQLITE_OK {
            for user in users {
                BindAttributes(ofUser: user, forStatement: insertStatement)
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted \(user.userName)")
                } else {
                    print("Could not insert \(user.userName)")
                }
                sqlite3_reset(insertStatement)
            }
            
            sqlite3_finalize(insertStatement)
        } else {
            print("INSERT statement could not be prepared.")
        }
    }
    
    func SelectUsers() -> [User]{
        var users = [User]()
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, selectUsersCommand, -1, &queryStatement, nil) == SQLITE_OK {
            
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                let user = User(firstname: String(cString: (sqlite3_column_text(queryStatement, 0))!),
                                lastName: String(cString: (sqlite3_column_text(queryStatement, 1))!),
                                email: String(cString: (sqlite3_column_text(queryStatement, 2))!),
                                userName: String(cString: (sqlite3_column_text(queryStatement, 3))!),
                                userPassword: String(cString: (sqlite3_column_text(queryStatement, 4))!)
                )
                users.append(user)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return users
    }
    
    func UpdatePassword(ofUser: User, withNewPassword: String) {
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateUserPasswordCommand, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, NSString(string: withNewPassword).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, NSString(string: ofUser.userName).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated \(ofUser.userName)")
            } else {
                print("Could not update \(ofUser.userName)")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    func deleteUserWithName(userName: String){
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteUserWithUserNameCommand, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, NSString(string: userName).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted \(userName).")
            } else {
                print("Could not delete all users.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func deleteAllUsers() {
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteAllUsersCommand, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted all users.")
            } else {
                print("Could not delete all users.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
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
    
    
    
    
    func openDatabase() -> OpaquePointer? {
        let dbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbName)
        
        if sqlite3_open(dbPath.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
        } else {
            print("Unable to open database. Verify that you created the directory described " + "in the Getting Started section.")
        }
        return db
    }
    
    func createTable() {
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createCommand, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Users table created.")
            } else {
                print("Users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    
    // SQL STATEMENTS {
    let inserUserCommand = """
                                INSERT
                                INTO Users (firstName, lastName, email, userName, userPassword)
                                VALUES (?, ?, ?, ?, ?);
                           """
    let selectUsersCommand = """
                                SELECT firstName, lastName, email, userName, userPassword
                                FROM Users;
                             """
    let updateUserCommand = """
                                UPDATE Users
                                SET firstName = ?,
                                lastName = ?,
                                email = ?
                                WHERE userName = ?;
                            """
    let updateUserPasswordCommand = """
                                        UPDATE Users
                                        SET userPassword = ?
                                        WHERE userName = ?;
                                    """
    
    let deleteUserWithIDCommand = """
                                        DELETE
                                        FROM Users
                                        WHERE Id = ?;
                                  """
    let deleteUserWithUserNameCommand = """
                                            DELETE
                                            FROM Users
                                            WHERE userName = ?;
                                        """
    let deleteAllUsersCommand = """
                                    DELETE
                                    FROM
                                    USERS;
                                """
    
    let createCommand = """
                            CREATE TABLE Users(
                            Id INT PRIMARY KEY AUTOINCREMENT,
                            firstName CHAR(255),
                            lastName CHAR(255),
                            email CHAR(255),
                            userName CHAR(255),
                            userPassword CHAR(255),
                            profileImage BLOB,
                            profileBanner BLOB
                            );
                        """
    
    // }
}