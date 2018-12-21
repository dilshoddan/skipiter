//
//  FileWorker.swift
//  Skipiter
//
//  Created by Admin on 12/21/18.
//  Copyright © 2018 Home. All rights reserved.
//
import UIKit
import Foundation

class FileWorker {
    
    func getDirectoryPath() -> NSURL {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("skipiterImages")
        let url = NSURL(string: path)
        return url!
    }
    
    func saveImageDocumentDirectory(image: UIImage, imageName: String) -> Bool{
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("skipiterImages")
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        let imageData = image.jpegData(compressionQuality: 1)
        //let imageData = UIImagePNGRepresentation(image)
        return fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
    
    func getImageFromDocumentDirectory(imageName: String) -> UIImage?{
        let imagePath = (self.getDirectoryPath() as NSURL).appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        if FileManager.default.fileExists(atPath: urlString) {
            return UIImage(contentsOfFile: urlString)
        } else {
            return nil
        }
    }
    
    func configureDirectory() -> String {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("skipiterProject")
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        return path
    }
    
    func deleteDirectory(directoryName : String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryName)
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
        }else{
            print("Directory not found")
        }
    }
    
}
