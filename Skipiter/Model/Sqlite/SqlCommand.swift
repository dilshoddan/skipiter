//
//  SqlCommands.swift
//  Skipiter
//
//  Created by Admin on 12/19/18.
//  Copyright © 2018 Home. All rights reserved.
//

extension String {
    
    public static let inserUserCommand = """
                                            INSERT
                                            INTO Users_ (firstName, lastName, email, userName, userPassword)
                                            VALUES (?, ?, ?, ?, ?);
                                        """
    
    public static let selectUsersCommand = """
                                                SELECT firstName, lastName, email, userName, userPassword
                                                FROM Users_;
                                             """
    
    public static let selectUserWithUserNameAndPasswordCommand = """
                                                        SELECT firstName, lastName, email, userName, userPassword, profileImage, profileBanner
                                                        FROM Users_
                                                        WHERE userName = ?
                                                        AND userPassword = ?;
                                                     """
    public static let selectUserWithUserNameCommand = """
                                                        SELECT COUNT(*)
                                                        FROM Users_
                                                        WHERE userName = ?;
                                                     """
    
//    public static let updateUserProfileImageCommand = """
//                                                            UPDATE Users
//                                                            SET profileImage = ?
//                                                            WHERE userName = ?;
//                                                        """
    
    public static let updateUserCommand = """
                                            UPDATE Users_
                                            SET firstName = ?,
                                            lastName = ?,
                                            email = ?
                                            WHERE userName = ?;
                                        """
    
    public static let updateUserPasswordCommand = """
                                                    UPDATE Users_
                                                    SET userPassword = ?
                                                    WHERE userName = ?;
                                                """
    
    public static let deleteUserWithIDCommand = """
                                                    DELETE
                                                    FROM Users_
                                                    WHERE Id = ?;
                                              """
    
    public static let deleteUserWithUserNameCommand = """
                                                            DELETE
                                                            FROM Users_
                                                            WHERE userName = ?;
                                                        """
    
    public static let deleteAllUsersCommand = """
                                                    DELETE
                                                    FROM
                                                    Users;
                                                """
    
    public static let createCommand = """
                                            CREATE TABLE IF NOT EXISTS Users_(
                                            Id INTEGER PRIMARY KEY AUTOINCREMENT,
                                            firstName CHAR(255),
                                            lastName CHAR(255),
                                            email CHAR(255) NOT NULL,
                                            userName CHAR(255) UNIQUE,
                                            userPassword CHAR(255) NOT NULL,
                                            profileImage TEXT,
                                            profileBanner TEXT
                                            );
                                        """
    
    
}
