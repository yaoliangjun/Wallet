//
//  AboutViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/20.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupSubViews() {
        title = NSLocalizedString("关于牛盾钱包", comment: "")

        let scrollView = UIScrollView()
        scrollView.backgroundColor = GlobalConstants.backgroundColor
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        // 内容
        let contentLabel = UILabel(text: NSLocalizedString("牛盾钱包是沃伦科技有限公司推出的手机APP，是一款牛盾资产的管理辅助工具，用户可以随时随地查看自己的账户余额，进行牛盾币转账。\n\n牛盾钱包采用区块链技术下的分布式记账方式，将两个钱包之间的传输所产生数据交易，记录在其他的点上，使得任何人无法通过黑入个别点来篡改数据。在去中心化的基础上，加密仅仅只是以公钥私钥的形式认证每个账户的签名和证书，而非账户资产，真正的确保了每个人的资产安全。", comment: ""), textColor: UIColor.white, font: UIFont(14), numberOfLines: 0)
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(contentView)
        }

        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentLabel.snp.bottom).offset(20)
        }
    }
}
