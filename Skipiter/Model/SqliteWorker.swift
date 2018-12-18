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
    
    init() {
        db = openDatabase()
    }
    
    
    func openDatabase() -> OpaquePointer? {
        let dbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("skipiterDatabase.sqlite")
        
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

    func insert(user: User) {
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertCommand, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, NSString(string: user.firstName).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 1, NSString(string: user.lastName).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 1, NSString(string: user.email).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 1, NSString(string: user.userName).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 1, NSString(string: user.userPassword).utf8String, -1, nil)
            
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
        if sqlite3_prepare_v2(db, insertCommand, -1, &insertStatement, nil) == SQLITE_OK {
            for user in users {
                sqlite3_bind_text(insertStatement, 1, NSString(string: user.firstName).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 1, NSString(string: user.lastName).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 1, NSString(string: user.email).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 1, NSString(string: user.userName).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 1, NSString(string: user.userPassword).utf8String, -1, nil)
                
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

    
    //SQL STATEMENTS
    let insertCommand = "INSERT INTO Users (firstName, lastName, email, userName, userPassword) VALUES (?, ?, ?, ?, ?);"

    
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
    
    
}
