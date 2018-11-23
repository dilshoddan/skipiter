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

class ProfileViewController: UIViewController {

    private var profileView = UIView()
    private var bannerImage = UIImageView()
    private var profileImage = UIImageView()
    private var segmentedControl: UISegmentedControl!
    private var logOutButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
    }
    
    @objc func LogOutTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func render(){
        
        view.sv([profileView])
        profileView.sv([bannerImage, profileImage, segmentedControl, logOutButton])
        
        profileView.height(100%).width(100%)
        
        bannerImage.height(24%).width(100%).centerHorizontally()
        bannerImage.Top == profileView.Top
        
        profileImage.height(18%).width(30%).left(15)
        profileImage.CenterY == bannerImage.Bottom
        
        segmentedControl.height(5%).width(90%).centerHorizontally()
        segmentedControl.Bottom == profileView.Bottom
        
        logOutButton.height(5%).width(20%)
        logOutButton.Bottom == bannerImage.Bottom
        logOutButton.Right == bannerImage.Right
        
        
        
    }
    
    func SetControlDefaults(){
        profileView.backgroundColor = .white
        
        bannerImage.backgroundColor = ColorConstants.ProfileVC
        profileView.addSubview(bannerImage)
        
        profileImage.backgroundColor = ColorConstants.ProfileVC
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.cornerRadius = 5.0
        profileView.addSubview(profileImage)
        
        segmentedControl = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
        segmentedControl.tintColor = ColorConstants.LoginViewVC
        profileView.addSubview(segmentedControl)
        
        logOutButton.backgroundColor = ColorConstants.LoginViewVC
        logOutButton.tintColor = ColorConstants.LoginViewVC
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.layer.cornerRadius = 5
        logOutButton.clipsToBounds = true
        logOutButton.isEnabled = true
        logOutButton.isUserInteractionEnabled = true
        logOutButton.setTitle("Out", for: .normal)
        logOutButton.addTarget(self, action: #selector(LogOutTapped), for: .touchUpInside)
        
        
        
    }


}
