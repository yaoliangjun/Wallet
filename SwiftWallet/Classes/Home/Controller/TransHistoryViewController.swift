//
//  TransHistoryViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/23.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  资产交易历史

import UIKit

class TransHistoryViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupSubViews() {
        title = "资产交易历史"
        tableView = createTableView(style: .plain, needRefresh: true)
        tableView?.tableHeaderView = tableHeaderView
        tableView?.allowsSelection = false
        view.addSubview(tableView!)
    }

    fileprivate lazy var tableHeaderView: DateSearchView = {
        var tableHeaderView = DateSearchView()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 70)
        tableHeaderView.delegage = self
        return tableHeaderView
    }()
}

extension TransHistoryViewController: DateSearchViewDelegate {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseId = "CellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseId)
        }
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // MARK: - DateSearchViewDelegate
    func dateSearchViewDelegate(_ dateSearchView: DateSearchView, startDate: String?, endDate: String?) {
        Logger("startDate: \(startDate), endDate: \(endDate)")
    }
}

