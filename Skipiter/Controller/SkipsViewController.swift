//
//  SkipsViewController.swift
//  Skipiter
//
//  Created by Admin on 1/12/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Hero
import Stevia

class SkipsViewController: UIViewController {

    private var skipsView: SkipsView!
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetDBDefaults()
        AddTapGestures()
    }
    
    @objc func SegmentedControlValueChanged(selectedControl: UISegmentedControl){
        switch selectedControl.selectedSegmentIndex {
        case 0:
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        case 3:
            navigationController?.popToRootViewController(animated: true)
        default:
            break
        }
        
    }
    
    func render(){
        view.sv(skipsView)
        skipsView.height(100%).width(100%).centerInContainer()
    }
    func SetControlDefaults(){
        
        skipsView = SkipsView(frame: view.bounds)
        skipsView.backgroundColor = .white
        
        skipsView.segmentedControl.addTarget(self, action: #selector(SegmentedControlValueChanged(selectedControl:)), for: .valueChanged)
        
    }
    
    func AddTapGestures(){
    }
    
    func SetDBDefaults(){
    }

}
