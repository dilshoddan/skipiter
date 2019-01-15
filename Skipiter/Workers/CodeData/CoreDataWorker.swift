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
        coreUser.setValue(fromUser.email, forKey: "email")
        coreUser.setValue(fromUser.userName, forKey: "userName")
    }
    
    func CreateUserFor(coreUser: NSManagedObject) -> User {
        return User(userName: coreUser.value(forKey: "userName") as! String,
                    email: coreUser.value(forKey: "email") as! String)
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
