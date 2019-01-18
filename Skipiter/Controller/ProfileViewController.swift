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

class ProfileViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    public var profileView: ProfileView!
    public var user: User!
    private var profileImagePicker: UIImagePickerController!
    private var profileBannerPicker: UIImagePickerController!
    public var skips: [AlamofireWorker.listAllSkipsJsonData] = [AlamofireWorker.listAllSkipsJsonData] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetDBDefaults()
        AddTapGestures()
        ListUserSkips()
    }
    
    func ListUserSkips(){
        profileView.activityIndicator.isHidden = false
        profileView.activityIndicator.startAnimating()
        
        skips.append(AlamofireWorker.listAllSkipsJsonData(date: "2019", text: "some text", userName: "MyName"))
        
        profileView.skipsTable.register(SkipTableViewCell.self, forCellReuseIdentifier: "Skip")
        profileView.skipsTable.delegate = self
        profileView.skipsTable.dataSource = self
        
        AlamofireWorker.ListUserSkips()
            .done { tuple in
                
                if tuple.1 {
                    self.skips = AlamofireWorker.ConvertDictionaryToSkips(tuple.0)
                    
                    self.profileView.skipsTable.reloadData()
                    self.profileView.skipsTable.estimatedRowHeight = 600
                    self.profileView.skipsTable.rowHeight = UITableView.automaticDimension
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: "Cannot connect to Internet", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        print("Cannot connect to Internet")
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                self.profileView.activityIndicator.stopAnimating()
                self.profileView.activityIndicator.isHidden = true
                self.profileView.activityIndicator.removeFromSuperview()
                
            }
            .catch { error in
                print(error.localizedDescription)
        }
        
        profileView.skipsTable.estimatedRowHeight = 600
        profileView.skipsTable.rowHeight = UITableView.automaticDimension
    }
    
    func render(){
        view.sv(profileView)
        profileView.height(100%).width(100%).centerInContainer()
    }
    func SetControlDefaults(){
        
        profileView = ProfileView(frame: view.bounds)
        profileView.backgroundColor = .white
        
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
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        coreDataWorker = CoreDataWorker(appDelegate: appDelegate)
    }
    
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Skip", for: indexPath) as! SkipTableViewCell;
        let skip = skips[indexPath.row]
        cell.skip = skip
        return cell;
    }
    
    
}
