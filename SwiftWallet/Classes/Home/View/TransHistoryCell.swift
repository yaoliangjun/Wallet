//
//  TransHistoryCell.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/26.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  交易记录Cell

import UIKit

class TransHistoryCell: CommonTableViewCell {

    fileprivate var statusImageView: UIImageView?
    fileprivate var amountLabel: UILabel?
    fileprivate var dateLabel: UILabel?
    fileprivate var addressLabel: UILabel?

    func setupModel(transHistoryModel: TransHistoryModel) {
        if transHistoryModel.category == 1 {
            // 转入
            statusImageView?.image = UIImage(named: "history_to")
            amountLabel?.text = "+" + transHistoryModel.amount.defaultDecimalPoint()

        } else {
            // 转出
            statusImageView?.image = UIImage(named: "go_to_history")
            amountLabel?.text = "-" + transHistoryModel.amount.defaultDecimalPoint()
        }

        addressLabel?.text = transHistoryModel.address
        dateLabel?.text = NSDate.dateString(millisecond: transHistoryModel.createDate, GlobalEnum.DateFormatter.yyyymmddhhmm.rawValue)
    }

    override func setupSubViews() {
        // 交易状态
        statusImageView = UIImageView()
        contentView.addSubview(statusImageView!)
        statusImageView!.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(28)
        }

        // 交易金额
        amountLabel = UILabel(text: nil, textColor: UIColor.white, font: UIFont(14))
        contentView.addSubview(amountLabel!)
        amountLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(statusImageView!.snp.right).offset(10)
            make.top.equalTo(statusImageView!).offset(-8)
            make.height.equalTo(20)
        }

        // 货币符号
        let coinSymbolView = UIImageView(imageName: "unit50")
        contentView.addSubview(coinSymbolView)
        coinSymbolView.snp.makeConstraints { (make) in
            make.left.equalTo(amountLabel!.snp.right).offset(5)
            make.centerY.equalTo(amountLabel!)
            make.width.height.equalTo(14)
            make.right.lessThanOrEqualTo(contentView).offset(-110)
        }

        // 交易时间
        dateLabel = UILabel(text: nil, textAlignment: .right, textColor: UIColor.white, font: UIFont(10))
        contentView.addSubview(dateLabel!)
        dateLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(amountLabel!)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(15)
            make.width.equalTo(100)
        }

        // 交易地址
        addressLabel = UILabel(text: nil, textColor: UIColor.white, font: UIFont(13), numberOfLines: 0)
        contentView.addSubview(addressLabel!)
        addressLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(amountLabel!)
            make.top.equalTo(amountLabel!.snp.bottom)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
        }
    }
}
