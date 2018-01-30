//
//  MineViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/11.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class MineViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Private Method
    @objc fileprivate func logoutBtnClick() {
        let alertController = UIAlertController(title: NSLocalizedString("提示", comment: ""), message: NSLocalizedString("确定要退出登录吗?", comment: ""), preferredStyle: .alert, positiveActionTitle: NSLocalizedString("确定", comment: ""), positiveCompletionHandle: { (alert) in
            (UIApplication.shared.delegate as! AppDelegate).logout()

        }, negativeActionTitle: NSLocalizedString("取消", comment: "")) { (alert) in

        }
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        tableView = createTableView(delegate: self, style: .plain)
        tableView?.tableFooterView = tableFooterView
        view.addSubview(tableView!)
    }

    fileprivate var titleArray: [String] = {
        var titleArray = ["", // 账号
            NSLocalizedString("登录密码", comment: ""),
            NSLocalizedString("交易密码", comment: ""),
            NSLocalizedString("关于NXX钱包", comment: ""),
            NSLocalizedString("更新检查", comment: "")]
        return titleArray
    }()

    fileprivate var imageArray: [String] = {
        var imageArray = ["", // 账号
            "set_up_login_password",
            "set_up_trading_password",
            "about_icon",
            "set_up_update_check"]
        return imageArray
    }()

    fileprivate var tableFooterView: UIView = {
        var tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 120))
        let logoutBtn = CommonButton(title: NSLocalizedString("退出登录", comment: ""), target: self, selector: #selector(logoutBtnClick))
        tableFooterView.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(tableFooterView).offset(20)
            make.right.equalTo(tableFooterView).offset(-20)
            make.top.equalTo(tableFooterView).offset(60)
        }

        return tableFooterView
    }()
}

extension MineViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommonTableViewCell.cellWithTableView(tableView)
        let section = indexPath.section
        if section == 0 {
            // 设置账号
            var account = UserDefaults.standard.object(forKey: AppConstants.account) as? NSString
            account = account ?? ""
            if account!.length >= 11 {
                account = account?.replacingCharacters(in: NSMakeRange(3, 4), with: "****") as NSString?
            }
            cell.textLabel?.text = account! as String
            cell.imageView?.image = nil
            
        } else {
            cell.textLabel?.text = titleArray[section]
            cell.imageView?.image = UIImage(named: imageArray[section])
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }

        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = GlobalConstants.backgroundColor;
        return sectionHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 15
    }
}

