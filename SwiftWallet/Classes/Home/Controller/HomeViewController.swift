//
//  HomeViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/11.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  主页

import UIKit

class HomeViewController: BaseViewController {

    fileprivate var balanceLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBalance()
    }

    // MARK: - HTTP
    fileprivate func fetchBalance() {
        let params = ["coinSymbol": AppConstants.appCoinSymbol]
        HomeServices.balance(params: params, showHUD: true, success: { (response) in
            self.balanceLabel?.text = response?.useable.defaultDecimalPoint()

        }) { (error) in

        }
    }

    // MARK: - Private Method
    @objc fileprivate func transferBtnClick() {
        navigationController?.pushViewController(ExchangeViewController(), animated: true)
    }

    @objc fileprivate func transHistoryBtnClick() {
        navigationController?.pushViewController(TransHistoryViewController(), animated: true)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {

        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
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

        // Banner
        var bannerViewHeight = 280
        if UIDevice.matchSize(4.7) {
            bannerViewHeight = 240

        } else if UIDevice.matchSize(3.5) || UIDevice.matchSize(4) {
            bannerViewHeight = 220
        }

        let bannerView = UIImageView(imageName: "home_banner")
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(bannerViewHeight)
        }

        // 余额
        let balanceImageView = UIImageView(imageName: "available_balance_background")
        contentView.addSubview(balanceImageView)
        balanceImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(bannerView.snp.bottom)
            make.height.equalTo(90)
        }

        let balanceText = UILabel(text: NSLocalizedString("可用余额", comment: ""), textAlignment: .center, textColor: AppConstants.greyTextColor, font: UIFont(15))
        contentView.addSubview(balanceText)
        balanceText.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(balanceImageView).offset(25)
            make.height.equalTo(20)
        }

        balanceLabel = UILabel(text: nil, textAlignment: .center, textColor: AppConstants.goldColor, font: UIFont(18))
        contentView.addSubview(balanceLabel!)
        balanceLabel!.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(balanceText.snp.bottom).offset(5)
            make.height.equalTo(20)
        }

        let transferBtn = CommonButton(title: NSLocalizedString("转至交易所", comment: ""), target: self, selector: #selector(transferBtnClick))
        contentView.addSubview(transferBtn)
        transferBtn.snp.makeConstraints { (make) in
            make.top.equalTo(balanceImageView.snp.bottom).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(50)
        }

        let transHistoryBtn = CommonButton(title: NSLocalizedString("资产交易历史", comment: ""), target: self, selector: #selector(transHistoryBtnClick))
        contentView.addSubview(transHistoryBtn)
        transHistoryBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(transferBtn)
            make.top.equalTo(transferBtn.snp.bottom).offset(20)
        }

        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(transHistoryBtn.snp.bottom).offset(20)
        }
    }
}
