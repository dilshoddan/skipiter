//
//  SkipTableViewCell.swift
//  Skipiter
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 Home. All rights reserved.
//
import UIKit
import Stevia

class SkipTableViewCell: UITableViewCell {
    
    var rightView: UIView = UIView()
    var leftView: UIView = UIView()
    var bottomView: UIView = UIView()
    
    var skip : AlamofireWorker.listAllSkipsJsonData? {
        didSet {
            userName.text = "@" + (skip?.userName ?? "") + ":"
            userSkip.text = skip?.text
            userSkipDate.text = skip?.date
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
    
    private let replyImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Reply")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let reTweetImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Retweet")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let loveImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Love")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let messageImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Messages")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let userName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    private let userSkip : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let userSkipDate : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
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
        
        sv([profileImage, userName, userSkipDate, userSkip])
        //, replyImage, reTweetImage, loveImage, messageImage])
        //        userName.top(0)
        userName.top(3)
        
        profileImage.size(50).left(5%)
        profileImage.Right == userName.Left - 5
        profileImage.bottom(3)
        
        userName.Left == userSkip.Left
        align(tops: [profileImage, userName, userSkipDate])
        
        userSkip.Top == userName.Bottom
        userSkip.Left == userName.Left
        userSkip.right(5%)
        userSkip.bottom(0)
        
        userSkipDate.right(5%)
        self.bottom(0)
        
        
        
        
        
        //        userName.top(0)
        //        userSkip.bottom(0)
        //        profileImage.width(10%).left(5%)
        //        replyImage.width(3%)
        //        reTweetImage.width(3%)
        //        loveImage.width(3%)
        //        messageImage.width(3%)
        
        //        userSkip.width(75%)
        //        userSkip.Left == profileImage.Right + 15
        
        //        align(tops: [profileImage, userName, userSkipDate])
        
        
        
        //        sv([leftView, rightView])
        //        leftView.width(10%)
        //        rightView.width(80%)
        //        leftView.Top == rightView.Top
        //        layout(
        //            0,
        //            |-leftView-rightView-|,
        //            0
        //        )
        //
        //
        //
        //        leftView.sv(profileImage)
        //        profileImage.fillContainer()
        //        leftView.layout(
        //            0,
        //            |-profileImage-|,
        //            0
        //        )
        //
        //        //        rightView.fillContainer()
        //        rightView.sv([userName, userSkip, userSkipDate, bottomView])
        //        rightView.layout (
        //            0,
        //            |-userName-|,
        //            0,
        //            |-userSkip-|,
        //            0,
        //            |-userSkipDate-|,
        //            0,
        //            |-bottomView-|,
        //            0
        //        )
        //
        //        bottomView.sv([replyImage, reTweetImage, loveImage, messageImage])
        //
        //        bottomView.layout(
        //            3,
        //            |-replyImage-45-reTweetImage-80-loveImage-45-messageImage-|,
        //            5
        //        )
        
        
    }
    
}



