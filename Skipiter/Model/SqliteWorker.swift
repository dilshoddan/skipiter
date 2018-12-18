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
    
    let createTableString = """
        CREATE TABLE Users(
        Id INT PRIMARY KEY NOT NULL,
        firstName CHAR(255),
        lastName CHAR(255),
        email CHAR(255),
        userName CHAR(255),
        userPassword CHAR(255)
        );
        """
    
    
}
