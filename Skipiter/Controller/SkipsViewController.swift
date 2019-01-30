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
import PromiseKit

class SkipsViewController: UIViewController {

    public var skipsView: SkipsView!
    public var user: User!
    public var skips: [AlamofireWorker.listAllSkipsJsonData] = [AlamofireWorker.listAllSkipsJsonData] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
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
        case 1:
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        case 3:
//            navigationController?.popToRootViewController(animated: true)
            let loginVC = LoginViewController()
            navigationController?.pushViewController(loginVC, animated: true)
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
        skipsView.activityIndicator.isHidden = false
        skipsView.activityIndicator.startAnimating()
        
        
        skips.append(AlamofireWorker.listAllSkipsJsonData(date: "2018", text: "Let's have a long text to see cell is able to show them all propperly. I doubt but still hope", userName: "myName"))
        skips.append(AlamofireWorker.listAllSkipsJsonData(date: "2019", text: "Let's have a long text to see cell is able to show them all propperly. I doubt but still hope", userName: "myName"))
        self.skipsView.skipsTable.reloadData()
        
        self.skipsView.skipsTable.rowHeight = UITableView.automaticDimension
        self.skipsView.skipsTable.estimatedRowHeight = 600
        self.skipsView.skipsTable.setNeedsUpdateConstraints()
        self.skipsView.skipsTable.updateConstraintsIfNeeded()
        
        skipsView.skipsTable.register(SkipTableViewCell.self, forCellReuseIdentifier: "Skip")
        skipsView.skipsTable.delegate = self
        skipsView.skipsTable.dataSource = self
        
        AlamofireWorker.ListAllSkips()
            .done{ tuple in
                
                if tuple.1 {
                    self.skips = AlamofireWorker.ConvertDictionaryToSkips(tuple.0)
                    
                    self.skipsView.skipsTable.reloadData()
                    
                    self.skipsView.skipsTable.rowHeight = UITableView.automaticDimension
                    self.skipsView.skipsTable.estimatedRowHeight = 600
                    self.skipsView.skipsTable.setNeedsUpdateConstraints()
                    self.skipsView.skipsTable.updateConstraintsIfNeeded()
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: "Cannot connect to Internet", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        print("Cannot connect to Internet")
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                self.skipsView.activityIndicator.stopAnimating()
                self.skipsView.activityIndicator.isHidden = true
                self.skipsView.activityIndicator.removeFromSuperview()
                
        }
            .catch { error in
                print(error.localizedDescription)
                
        }
        
        skipsView.skipsTable.estimatedRowHeight = 600
        skipsView.skipsTable.rowHeight = UITableView.automaticDimension
        
    }
    
    func AddTapGestures(){
    }
    
    func SetDBDefaults(){
    }
    
   

    
    
}


extension SkipsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Skip", for: indexPath) as! SkipTableViewCell;
        let skip = skips[indexPath.row]
        cell.skip = skip
        cell.detailTextLabel?.text = skips[indexPath.row].date
        return cell;
    }
    
}


