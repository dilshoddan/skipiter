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

    var subView: UIView = UIView()
    var skip : AlamofireWorker.listAllSkipsJsonData? {
        didSet {
            userName.text = "@" + (skip?.userName ?? "") + ":"
            userSkip.text = skip?.text
            userSkipDate.text = skip?.date
        }
    }
    
    private let userName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let userSkip : UITextView = {
        let txt = UITextView()
        txt.textColor = .black
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textAlignment = .left
        return txt
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
        sv([userName, userSkip, userSkipDate])
        userName.Left == self.Left
        userSkip.Left == userName.Right
        userSkipDate.Bottom == self.Bottom
        layout (
            |-userName-userSkip-|,
            2,
            |-userSkipDate-|
        )
    }

}


//import UIKit
//class ProductCell : UITableViewCell {
//
//    var product : Product? {
//        didSet {
//            productImage.image = product?.productImage
//            productNameLabel.text = product?.productName
//            productDescriptionLabel.text = product?.productDesc
//        }
//    }
//
//
//    private let productNameLabel : UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.boldSystemFont(ofSize: 16)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//
//
//    private let productDescriptionLabel : UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 16)
//        lbl.textAlignment = .left
//        lbl.numberOfLines = 0
//        return lbl
//    }()
//
//    private let decreaseButton : UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(#imageLiteral(resourceName: “minusTb”), for: .normal)
//        btn.imageView?.contentMode = .scaleAspectFill
//        return btn
//    }()
//
//    private let increaseButton : UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(#imageLiteral(resourceName: “addTb”), for: .normal)
//        btn.imageView?.contentMode = .scaleAspectFill
//        return btn
//    }()
//    var productQuantity : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.textAlignment = .left
//        label.text = “1”
//        label.textColor = .black
//        return label
//
//    }()
//
//    private let productImage : UIImageView = {
//        let imgView = UIImageView(image: #imageLiteral(resourceName: “glasses”))
//        imgView.contentMode = .scaleAspectFit
//        imgView.clipsToBounds = true
//        return imgView
//    }()
//
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(productImage)
//        addSubview(productNameLabel)
//        addSubview(productDescriptionLabel)
//        addSubview(decreaseButton)
//        addSubview(productQuantity)
//        addSubview(increaseButton)
//
//        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
//        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
//        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
//
//
//        let stackView = UIStackView(arrangedSubviews: [decreaseButton,productQuantity,increaseButton])
//        stackView.distribution = .equalSpacing
//        stackView.axis = .horizontal
//        stackView.spacing = 5
//        addSubview(stackView)
//        stackView.anchor(top: topAnchor, left: productNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError(“init(coder:) has not been implemented”)
//    }
//
//
//}
