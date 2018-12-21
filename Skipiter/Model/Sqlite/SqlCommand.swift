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
                                            INTO Usrs (firstName, lastName, email, userName, userPassword)
                                            VALUES (?, ?, ?, ?, ?);
                                        """
    
    public static let selectUsersCommand = """
                                                SELECT firstName, lastName, email, userName, userPassword
                                                FROM Usrs;
                                             """
    
    public static let selectUserWithUserNameAndPasswordCommand = """
                                                        SELECT firstName, lastName, email, userName, userPassword, profileImage, profileBanner
                                                        FROM Usrs
                                                        WHERE userName = ?
                                                        AND userPassword = ?;
                                                     """
    public static let selectUserWithUserNameCommand = """
                                                        SELECT COUNT(*)
                                                        FROM Usrs
                                                        WHERE userName = ?;
                                                     """
    
    public static let updateUserProfileImageCommand = """
                                                            UPDATE Usrs
                                                            SET profileImage = ?
                                                            WHERE userName = ?;
                                                        """
    
    public static let updateUserProfileBannerCommand = """
                                                            UPDATE Usrs
                                                            SET profileBanner = ?
                                                            WHERE userName = ?;
                                                        """
    
    public static let updateUserCommand = """
                                            UPDATE Usrs
                                            SET firstName = ?,
                                            lastName = ?,
                                            email = ?
                                            WHERE userName = ?;
                                        """
    
    public static let updateUserPasswordCommand = """
                                                    UPDATE Usrs
                                                    SET userPassword = ?
                                                    WHERE userName = ?;
                                                """
    
    public static let deleteUserWithIDCommand = """
                                                    DELETE
                                                    FROM Usrs
                                                    WHERE Id = ?;
                                              """
    
    public static let deleteUserWithUserNameCommand = """
                                                            DELETE
                                                            FROM Usrs
                                                            WHERE userName = ?;
                                                        """
    
    public static let deleteAllUsersCommand = """
                                                    DELETE
                                                    FROM
                                                    Usrs;
                                                """
    
    public static let createCommand = """
                                            CREATE TABLE IF NOT EXISTS Usrs(
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
