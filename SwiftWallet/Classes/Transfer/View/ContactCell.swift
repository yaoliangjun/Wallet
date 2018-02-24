//
//  ContactCell.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/30.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import HandyJSON

class ContactCell: CommonTableViewCell {

    fileprivate var nameLabel: UILabel?
    fileprivate var addressLabel: UILabel?

    func setupModel(_ contactModel: ContactModel?) {
        nameLabel?.text = contactModel?.nickName
        addressLabel?.text = contactModel?.address
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        // 联系人名字
        nameLabel = UILabel(text: nil, textColor: UIColor.white, font: UIFont(15))
        contentView.addSubview(nameLabel!)
//
        // 地址
        addressLabel = UILabel(text: nil, textColor: UIColor.white, font: UIFont(13))
        contentView.addSubview(addressLabel!)

        nameLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(22)
        }

        addressLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel!.snp.bottom)
            make.left.width.height.equalTo(nameLabel!)
        }
    }
}
