//
//  SkipTableViewCell.swift
//  Skipiter
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 Home. All rights reserved.
//
import UIKit
import Stevia

protocol SkipTableViewCellDelegate: class {
    func replyTapped(_ sender: AlamofireWorker.listAllSkipsJsonData?)
    func reTweetTapped(_ sender: AlamofireWorker.listAllSkipsJsonData?)
    func loveTapped(_ sender: AlamofireWorker.listAllSkipsJsonData?)
    func messageTapped(_ sender: AlamofireWorker.listAllSkipsJsonData?)
}

class SkipTableViewCell: UITableViewCell {
    
    public var delegate: SkipTableViewCellDelegate?
    
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
    
    public let replyImage : UIButton = {
        let img = UIButton()
        img.setBackgroundImage(UIImage(named: "Reply")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        return img
    }()
    
//    private let replyImage : UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "Reply")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        img.contentMode = .scaleAspectFill
//        img.clipsToBounds = true
//        return img
//    }()
    
    private let reTweetImage : UIButton = {
        let img = UIButton()
        img.setBackgroundImage(UIImage(named: "Retweet")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        
        return img
    }()
    
//    private let reTweetImage : UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "Retweet")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        img.contentMode = .scaleAspectFill
//        img.clipsToBounds = true
//        return img
//    }()
    
    private let loveImage : UIButton = {
        let img = UIButton()
        img.setBackgroundImage(UIImage(named: "Love")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        return img
    }()
    
//    private let loveImage : UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "Love")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        img.contentMode = .scaleAspectFill
//        img.clipsToBounds = true
//        return img
//    }()
    
    private let messageImage : UIButton = {
        let img = UIButton()
        img.setBackgroundImage(UIImage(named: "Messages")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        return img
    }()
    
//    private let messageImage : UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "Messages")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        img.contentMode = .scaleAspectFill
//        img.clipsToBounds = true
//        return img
//    }()
    
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
        
        AddButtonActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetConstraints(){
        
        bottomView.sv([replyImage, reTweetImage, loveImage, messageImage])
        bottomView.layout(
            0,
            |-replyImage-reTweetImage-10-loveImage-10-messageImage-|,
            0
        )
        
        sv([profileImage, userName, userSkipDate, userSkip, replyImage, reTweetImage, loveImage, messageImage])
        
        userName.top(3)
        
        profileImage.size(50).left(5%)
        profileImage.Right == userName.Left - 5
        
        
        userName.Left == userSkip.Left
        userSkipDate.right(5%)
        align(tops: [profileImage, userName, userSkipDate])
        
        userSkip.Top == userName.Bottom
        userSkip.Left == userName.Left
        userSkip.right(5%)
        
        replyImage.Top == userSkip.Bottom + 10
        
        align(tops: [replyImage, reTweetImage, loveImage, messageImage])
        replyImage.Left == userName.Left
        replyImage.Right == reTweetImage.Left - 40
        reTweetImage.Right == loveImage.Left - 40
        loveImage.Right == messageImage.Left - 40
        replyImage.bottom(10)
        
    }
    
    @objc func ReplyTapped(_ sender: UIButton){
        delegate?.replyTapped(skip)
            //skip)
    }
    
    @objc func ReTweetTapped(_ sender: UIButton){
        delegate?.reTweetTapped(skip)
        
    }
    
    @objc func LoveTapped(_ sender: UIButton){
        delegate?.loveTapped(skip)
    }
    
    @objc func MessageTapped(_ sender: UIButton){
        delegate?.messageTapped(skip)
    }
        
    func AddButtonActions(){
        replyImage.addTarget(self, action: #selector(ReplyTapped(_:)), for: .touchUpInside)
        reTweetImage.addTarget(self, action: #selector(ReTweetTapped(_:)), for: .touchUpInside)
        loveImage.addTarget(self, action: #selector(LoveTapped(_:)), for: .touchUpInside)
        messageImage.addTarget(self, action: #selector(MessageTapped(_:)), for: .touchUpInside)
    }
    
}



