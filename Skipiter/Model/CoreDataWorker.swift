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
    
    init(appDelegate: AppDelegate) {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func SetValuesTo(coreUser: NSManagedObject, fromUser: User){
        coreUser.setValue(fromUser.firstName, forKeyPath: "firstName")
        coreUser.setValue(fromUser.lastName, forKey: "lastName")
        coreUser.setValue(fromUser.email, forKey: "email")
        coreUser.setValue(fromUser.userName, forKey: "userName")
        coreUser.setValue(fromUser.userPassword, forKey: "userPassword")
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
            for row in result {
                let user  = User(firstname: row.value(forKey: "firstName") as! String,
                                 lastName: row.value(forKey: "lastName") as! String,
                                 email: row.value(forKey: "email") as! String,
                                 userName: row.value(forKey: "userName") as! String,
                                 userPassword: row.value(forKey: "userPassword") as! String)
                users.append(user)
            }
        }
        catch let error as NSError{
            print("Could not get users. Error: \(error)")
        }
        
        return users
    }
    
    func Update(user: User, searchKey: String, searchValue: String){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "\(searchKey) = %@", "\(searchValue)")
        
        do{
            let fetchedUser = try managedContext.fetch(fetchRequest)
            if fetchedUser.count > 0 {
                let updateUser = fetchedUser[0] as! NSManagedObject
                SetValuesTo(coreUser: updateUser, fromUser: user)
            }
        }
        catch {
            print("Could not updated. Error: \(error)")
        }
    }
    
    func UpdateProfileImageOf(user: User, _ key: String){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "userName= %@", "\(user.userName)")
        
        do{
            let fetchedUser = try managedContext.fetch(fetchRequest)
            if fetchedUser.count > 0 {
                let updateUser = fetchedUser[0] as! NSManagedObject
                if key == "profileImage" {
                    updateUser.setValue(user.profileImage?.jpegData(compressionQuality: 1.0)!, forKey: key)
                }
                else if key == "profileBanner" {
                    updateUser.setValue(user.profileBanner?.jpegData(compressionQuality: 1.0)!, forKey: key)
                }
                
            }
        }
        catch {
            print("Could not updated. Error: \(error)")
        }
    }
    
    func IsAuthenticated(userName: String, userPassword: String) -> User? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "userName = %@", "\(userName)")
        var returnUser: User!
        do {
            let fetchedUser = try managedContext.fetch(fetchRequest)
            if fetchedUser.count > 0 {
                let user = fetchedUser[0] as! NSManagedObject
                let fetchedUserPassword = user.value(forKey: "userPassword") as! String
                if fetchedUserPassword == userPassword {
                    returnUser = User(firstname: user.value(forKey: "firstName") as! String,
                                      lastName: user.value(forKey: "lastName") as! String,
                                      email: user.value(forKey: "email") as! String,
                                      userName: user.value(forKey: "userName") as! String,
                                      userPassword: user.value(forKey: "userPassword") as! String)
                    
                    let profileImage = user.value(forKey: "profileImage") as? Data
                    if let profileImage = profileImage {
                        returnUser.profileImage = UIImage(data: profileImage)
                    }
                    let profileBanner = user.value(forKey: "profileBanner") as? Data
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
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "userName = %@", "\(userName)")
        do {
            let fetchedUser = try managedContext.fetch(fetchRequest)
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
