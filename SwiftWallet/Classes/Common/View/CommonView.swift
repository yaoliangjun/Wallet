//
//  CommonView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class CommonView: UIView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }

    func setupSubView() {
        let contentView = UIView()
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        let backgroundImageView = UIImageView(imageName: "list_background")
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
}
