//
//  ProfileViewController.swift
//  Skipiter
//
//  Created by Admin on 11/22/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia
import Hero

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var profileView: ProfileView!
    public var user: User!
    private var coreDataWorker: CoreDataWorker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetCoreDataDefaults()
        AddTapGestures()
    }
    
    @objc func LogOutTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func render(){
        view.sv(profileView)
        profileView.height(100%).width(100%).centerInContainer()
    }
    func SetControlDefaults(){
        
        profileView = ProfileView(frame: view.bounds)
        profileView.backgroundColor = .white
        profileView.logOutButton.addTarget(self, action: #selector(LogOutTapped), for: .touchUpInside)
        
        if let user = user, let profileImage = user.profileImage {
            profileView.profileImage.image = profileImage
        }
    }
    
    @objc func PickAnImage(recognizer:UITapGestureRecognizer){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileView.profileImage.image = selectedImage
        user.profileImage = selectedImage
        coreDataWorker.UpdateProfileImageOf(user: user)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func AddTapGestures(){
        
        profileView.profileImage.isUserInteractionEnabled = true
        let pickAnImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(PickAnImage(recognizer:)))
        profileView.profileImage.addGestureRecognizer(pickAnImageTapGesture)
    }
    
    func SetCoreDataDefaults(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataWorker = CoreDataWorker(appDelegate: appDelegate)
    }


}
