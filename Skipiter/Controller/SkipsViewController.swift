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

class SkipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    public var skipsView: SkipsView!
    public var user: User!
    public var skips = [AlamofireWorker.listAllSkipsJsonData] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetDBDefaults()
        AddTapGestures()
        ListAllSkips()
        
        //test data
        
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
    
    func ListAllSkips(){
        AlamofireWorker.ListAllSkips(self)
        skips.append(AlamofireWorker.listAllSkipsJsonData(text: "some text", date: Date()))
    }
    
    func AddTapGestures(){
    }
    
    func SetDBDefaults(){
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        let dateFormatter = DateFormatter()
        cell.textLabel?.text = dateFormatter.string(from: skips[indexPath.row].date)
        cell.detailTextLabel?.text = skips[indexPath.row].text
        return cell;
    }

}


