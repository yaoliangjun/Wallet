//
//  CommonTableViewCell.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/11/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  通用Cell

import UIKit
import HandyJSON

class CommonTableViewCell: BaseTableViewCell {

    static func cellWithTableView(_ tableView: UITableView) -> CommonTableViewCell {
        let cellReuseId = "cellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId) as? CommonTableViewCell
        if cell == nil {
            cell = self.init(style: .default, reuseIdentifier: cellReuseId)
            let backgroundImageView = UIImageView(imageName: "list_background")
            backgroundImageView.contentMode = .scaleToFill
            cell!.backgroundView = backgroundImageView
            cell?.textLabel?.font = UIFont(15)
            cell?.textLabel?.textColor = UIColor.white
            cell?.detailTextLabel?.font = UIFont(10)
            cell?.detailTextLabel?.textColor = UIColor.white
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
