//
//  SkipTableViewCell.swift
//  Skipiter
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 Home. All rights reserved.
//
import UIKit
import Stevia

class UsersTableViewCell: UITableViewCell {
    
    var rightView: UIView = UIView()
    var leftView: UIView = UIView()
    var bottomView: UIView = UIView()
    
    var user : AlamofireWorker.JsonUser? {
        didSet {
            userName.text = "@" + (user?.name ?? "")
        }
    }
    
    private let profileImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "l2")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 1.0
        img.layer.cornerRadius = 25.0
        
        return img
    }()
    
    
    
    private let userName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetConstraints()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetConstraints(){
        
        sv([profileImage, userName])
        
        userName.top(3)
        
        profileImage.size(50).left(5%)
        profileImage.Right == userName.Left - 5
        
        align(tops: [profileImage, userName])
        
        profileImage.bottom(0)
    }
    
}



