//
//  PlaceholderView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/26.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {

    fileprivate var placeholder: String?
    fileprivate var placeholderLabel: UILabel?
    fileprivate var placeholderImageName: String?

    convenience init(superView: UIView, placeholder: String, placeholderImageName: String) {
        self.init(frame: CGRect.zero)

        self.width = GlobalConstants.screenWidth
        self.centerY = superView.centerY
        self.height = 200
        self.placeholder = placeholder
        self.placeholderImageName = placeholderImageName

        superView.addSubview(self)
        setupSubView()
    }

    convenience init(frame: CGRect, superView: UIView, placeholder: String, placeholderImageName: String) {
        self.init(frame: CGRect.zero)

        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height + 15 + 20)
        self.centerX = superView.centerX
        self.placeholder = placeholder
        self.placeholderImageName = placeholderImageName

        superView.addSubview(self)
        setupSubView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Getter / Setter
    fileprivate func setupSubView() {
        backgroundColor = UIColor.clear
        isHidden = true
        let placeholderImageView = UIImageView(imageName: placeholderImageName!)
        self.addSubview(placeholderImageView)
        placeholderImageView.snp.makeConstraints { (make) in
             make.edges.equalTo(self)
        }

        placeholderLabel = UILabel(text: placeholder, textAlignment: .center, textColor: UIColor.white, font: UIFont(14))
        self.addSubview(placeholderLabel!)
        placeholderLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(placeholderImageView.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.height.equalTo(20)
        }
    }
}
