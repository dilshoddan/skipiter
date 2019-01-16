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
    private var profileImagePicker: UIImagePickerController!
    private var profileBannerPicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetDBDefaults()
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
        
        profileImagePicker = UIImagePickerController()
        profileBannerPicker = UIImagePickerController()
        
        profileView.segmentedControl.addTarget(self, action: #selector(SegmentedControlValueChanged(selectedControl:)), for: .valueChanged)
        
    }
    
    @objc func SegmentedControlValueChanged(selectedControl: UISegmentedControl){
        switch selectedControl.selectedSegmentIndex {
        case 0:
            let skipsVC = SkipsViewController()
            navigationController?.pushViewController(skipsVC, animated: true)
        case 3:
            navigationController?.popToRootViewController(animated: true)
        default:
            break
        }
        
    }
    
    @objc func PickProfileImage(recognizer:UITapGestureRecognizer){
        profileImagePicker.delegate = self
        self.present(profileImagePicker, animated: true, completion: nil)
    }
    
    @objc func PickProfileBanner(recognizer:UITapGestureRecognizer){
        profileBannerPicker.delegate = self
        self.present(profileBannerPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        switch picker {
        case profileImagePicker:
            profileView.profileImage.image = selectedImage
            //user.profileImage = selectedImage
            
            picker.dismiss(animated: true, completion: nil)
        case profileBannerPicker:
            profileView.profileBanner.image = selectedImage
            //user.profileBanner = selectedImage
            
            picker.dismiss(animated: true, completion: nil)
        default:
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func AddTapGestures(){
        profileView.profileImage.isUserInteractionEnabled = true
        let pickProfileImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(PickProfileImage(recognizer:)))
        profileView.profileImage.addGestureRecognizer(pickProfileImageTapGesture)
        
        profileView.profileBanner.isUserInteractionEnabled = true
        let pickProfileBannerTapGesture = UITapGestureRecognizer(target: self, action: #selector(PickProfileBanner(recognizer:)))
        profileView.profileBanner.addGestureRecognizer(pickProfileBannerTapGesture)
    }
    
    func SetDBDefaults(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataWorker = CoreDataWorker(appDelegate: appDelegate)
    }


}
