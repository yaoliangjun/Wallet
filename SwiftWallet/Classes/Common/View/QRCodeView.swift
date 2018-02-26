//
//  QRCodeView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/29.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class QRCodeView: UIView {

    var address: String?
    var qrCodeImageView: UIImageView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubViews()
    }

    // MARK: - Public Method
    func setupAddress(address: String?) {
        self.address = address
        qrCodeImageView!.image = UIImage.createQRCodeImage(address!, CGSize(width: self.width, height: self.height))
    }

    func qrCodeImage() -> UIImage? {
        return qrCodeImageView?.image
    }

    // MARK: - Getter / Setter
    fileprivate func setupSubViews() {
        // 二维码背景
        let qrCodeBackgroundView = UIView(backgroundColor: UIColor.white)
        qrCodeBackgroundView.layer.cornerRadius = 4
        qrCodeBackgroundView.layer.masksToBounds = true
        addSubview(qrCodeBackgroundView)
        qrCodeBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        // TODO:点击放大效果（ClickImageView）
        qrCodeImageView = UIImageView()
        qrCodeBackgroundView.addSubview(qrCodeImageView!)
        qrCodeImageView!.snp.makeConstraints { (make) in
            make.edges.equalTo(qrCodeBackgroundView).inset(UIEdgeInsetsMake(5, 5, 5, 5))
        }

        // LOGO
        let logoImageView = UIImageView(imageName: "app_icon")
        logoImageView.layer.cornerRadius = 24
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.borderWidth = 2
        logoImageView.layer.masksToBounds = true
        qrCodeImageView?.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.center.equalTo(qrCodeImageView!)
            make.width.height.equalTo(48)
        }
    }
}
