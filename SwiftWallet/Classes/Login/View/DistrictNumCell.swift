//
//  DistrictNumCell.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/5.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  区号cell

import UIKit

class DistrictNumCell: CommonTableViewCell {

    var chineseNameLabel: UILabel?
    var nationalNameLabel: UILabel?
    var codeLabel: UILabel?

    // 设置数据
    func setupDistrictModel(districtModel: DistrictModel) {
        let language = CommonUtils.defaultLanguage()
        if language.contains("zh") {
            chineseNameLabel?.text = districtModel.chineseName
            nationalNameLabel?.text = districtModel.nationalName

        } else {
            chineseNameLabel?.text = districtModel.nationalName
            nationalNameLabel?.text = districtModel.chineseName
        }

        codeLabel?.text = "+\(districtModel.code!)"
    }

    // 设置UI
    override func setupSubViews() {
        // 中文名字
        chineseNameLabel = UILabel(text: nil, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(chineseNameLabel!)

        // 英文名字
        nationalNameLabel = UILabel(text: nil, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(nationalNameLabel!)

        // 区号代码
        codeLabel = UILabel(text: nil, textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(codeLabel!)

        chineseNameLabel!.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(10);
            make.height.equalTo(20);
            make.right.equalTo(codeLabel!.snp.left);
        }

        nationalNameLabel!.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(chineseNameLabel!);
            make.top.equalTo(chineseNameLabel!.snp.bottom);
        }

        codeLabel!.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10);
            make.centerY.equalTo(contentView);
            make.width.equalTo(80);
            make.height.equalTo(20);
        }
    }
}
