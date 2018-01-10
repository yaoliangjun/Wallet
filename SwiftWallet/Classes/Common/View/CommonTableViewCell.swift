//
//  CommonTableViewCell.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/11/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  通用Cell

import UIKit

class CommonTableViewCell: BaseTableViewCell {

    static func cellWithTableView(tableView: UITableView) -> CommonTableViewCell {
        let cellReuseId = "cellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId) as? CommonTableViewCell
        if cell == nil {
            cell = self.init(style: .default, reuseIdentifier: cellReuseId)
            cell?.backgroundColor = UIColor.white
        }

        return cell!
    }

    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 子类重写该方法设置Cell
    func setupCell() {

    }

    /// 子类重写该方法设置视图
    func setupSubViews() {

    }
}
