//
//  DatabaseWorker.swift
//  Skipiter
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Home. All rights reserved.
//

import CoreData
import UIKit

class CoreDataWorker {
    private var managedContext: NSManagedObjectContext!
    private var usersFetchRequest: NSFetchRequest<NSFetchRequestResult>!
    
    init(appDelegate: AppDelegate) {
        managedContext = appDelegate.persistentContainer.viewContext
        usersFetchRequest = NSFetchRequest.init(entityName: "Users")
    }
    
    func SetValuesTo(coreUser: NSManagedObject, fromUser: User){
        coreUser.setValue(fromUser.firstName, forKeyPath: "firstName")
        coreUser.setValue(fromUser.lastName, forKey: "lastName")
        coreUser.setValue(fromUser.email, forKey: "email")
        coreUser.setValue(fromUser.userName, forKey: "userName")
        coreUser.setValue(fromUser.userPassword, forKey: "userPassword")
    }
    
    func CreateUserFor(coreUser: NSManagedObject) -> User {
        return User(firstname: coreUser.value(forKey: "firstName") as! String,
                    lastName: coreUser.value(forKey: "lastName") as! String,
                    email: coreUser.value(forKey: "email") as! String,
                    userName: coreUser.value(forKey: "userName") as! String,
                    userPassword: coreUser.value(forKey: "userPassword") as! String)
    }
    
    func SaveUser(user: User){
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        let coreUser = NSManagedObject(entity: entity, insertInto: managedContext)
        SetValuesTo(coreUser: coreUser, fromUser: user)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func ReadUsers() -> [User]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        var users = [User]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for coreUser in result {
                let user  = CreateUserFor(coreUser: coreUser)
                users.append(user)
            }
        }
        catch let error as NSError{
            print("Could not get users. Error: \(error)")
        }
        
        return users
    }
    
    func Delete(user: User){
        usersFetchRequest.predicate = NSPredicate(format: "userName = %@", "\(user.userName)")
        
        do{
            let fetchedUser = try managedContext.fetch(usersFetchRequest)
            if fetchedUser.count > 0 {
                let deleteUser = fetchedUser[0] as! NSManagedObject
                managedContext.delete(deleteUser)
                do {
                    try managedContext.save()
                }
                catch {
                    print("Could not delete the user: \(user) . Error: \(error)")
                }
            }
        }
        catch {
            print("Could not find the user. Error: \(error)")
        }
    }
    
    func Update(user: User){
        usersFetchRequest.predicate = NSPredicate(format: "userName = %@", "\(user.userName)")
        
        do{
            let fetchedUser = try managedContext.fetch(usersFetchRequest)
            if fetchedUser.count > 0 {
                let updateUser = fetchedUser[0] as! NSManagedObject
                SetValuesTo(coreUser: updateUser, fromUser: user)
            }
        }
        catch {
            print("Could not updated. Error: \(error)")
        }
    }
    
    func UpdateProfileImageOf(user: User, _ withKey: String){
        usersFetchRequest.predicate = NSPredicate(format: "userName= %@", "\(user.userName)")
        
        do{
            let fetchedUser = try managedContext.fetch(usersFetchRequest)
            if fetchedUser.count > 0 {
                let updateUser = fetchedUser[0] as! NSManagedObject
                if withKey == "profileImage" {
                    updateUser.setValue(user.profileImage?.jpegData(compressionQuality: 1.0)!, forKey: withKey)
                }
                else if withKey == "profileBanner" {
                    updateUser.setValue(user.profileBanner?.jpegData(compressionQuality: 1.0)!, forKey: withKey)
                }
                
            }
        }
        catch {
            print("Could not updated. Error: \(error)")
        }
    }
    
    func IsAuthenticated(userName: String, userPassword: String) -> User? {
        usersFetchRequest.predicate = NSPredicate(format: "userName = %@", "\(userName)")
        var returnUser: User!
        do {
            let fetchedUser = try managedContext.fetch(usersFetchRequest)
            if fetchedUser.count > 0 {
                let coreUser = fetchedUser[0] as! NSManagedObject
                let fetchedUserPassword = coreUser.value(forKey: "userPassword") as! String
                if fetchedUserPassword == userPassword {
                    returnUser = CreateUserFor(coreUser: coreUser)
                    
                    let profileImage = coreUser.value(forKey: "profileImage") as? Data
                    if let profileImage = profileImage {
                        returnUser.profileImage = UIImage(data: profileImage)
                    }
                    let profileBanner = coreUser.value(forKey: "profileBanner") as? Data
                    if let profileBanner = profileBanner {
                        returnUser.profileBanner = UIImage(data: profileBanner)
                    }
                }
            }
        }
        catch {
            return returnUser
        }
        return returnUser
    }
    
    func IsUnique(userName: String) -> Bool{
        usersFetchRequest.predicate = NSPredicate(format: "userName = %@", "\(userName)")
        do {
            let fetchedUser = try managedContext.fetch(usersFetchRequest)
            if fetchedUser.count == 0 {
                return true
            }
            else {
                return false
            }
        }
        catch{
            return false
        }
    }
}
