//
//  TransHistoryViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/23.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  资产交易历史

import UIKit
import MBProgressHUD

class TransHistoryViewController: BaseTableViewController {

    fileprivate var startDateMillisecond: String?
    fileprivate var endDateMillisecond: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransHistory()
    }

    // MARK: - HTTP
    fileprivate func fetchTransHistory() {
        var params = ["coinSymbol": AppConstants.appCoinSymbol, "page": String(pageNumber), "size": String(pageCount)]
        if let startDateMillisecond = startDateMillisecond {
            params["startTime"] = startDateMillisecond
        }
        if let endDateMillisecond = endDateMillisecond {
            params["endTime"] = endDateMillisecond
        }

        TransferServices.transHistories(params: params, showHUD: true, success: { (response) in

            let dataCount = response?.count

            // 下拉状态
            if self.refreshStatus == .pullDown {
                self.pageNumber = 1
                self.transHistoryArray.removeAll()

            } else {
                self.pageNumber = self.pageNumber + 1
            }

            // 有数据
            if dataCount != nil && dataCount! > 0 {
                self.transHistoryArray = self.transHistoryArray + response!
            }

            // 判断是否显示加载更多
            self.showFooterView(dataCount == self.pageCount)
            self.placeholderView?.isHidden = self.transHistoryArray.count > 0
            self.tableView?.reloadData()

        }) { (error) in

        }
    }
    
    // MARK: - Private Method
    override func pullDownHandle() {
        fetchTransHistory()
    }
    
    override func pullUpHandle() {
        fetchTransHistory()
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = "资产交易历史"
        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        tableView?.tableHeaderView = tableHeaderView
        tableView?.allowsSelection = false
        view.addSubview(tableView!)

        placeholderView = PlaceholderView(frame: CGRect(x: 0, y: 190, width: 115, height: 70), superView: tableView!, placeholder: NSLocalizedString("暂无历史记录", comment: ""), placeholderImageName: "home_no_history")
    }

    fileprivate lazy var tableHeaderView: DateSearchView = {
        var tableHeaderView = DateSearchView()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 70)
        tableHeaderView.delegage = self
        return tableHeaderView
    }()

    fileprivate lazy var transHistoryArray: [TransHistoryModel] = {
        var transHistoryArray = [TransHistoryModel]()
        return transHistoryArray
    }()
}

// MARK: - extension
extension TransHistoryViewController: DateSearchViewDelegate {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return transHistoryArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TransHistoryCell.cellWithTableView(tableView) as! TransHistoryCell
        cell.setupModel(transHistoryModel: transHistoryArray[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = GlobalConstants.backgroundColor;
        return sectionHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // MARK: - DateSearchViewDelegate
    func dateSearchViewDelegate(_ dateSearchView: DateSearchView, startDate: String?, endDate: String?) {
        if !(startDate?.isEmpty)! {
            startDateMillisecond = NSDate.millisecond(dateString: String(format: "%@ %@", startDate!, "0:0:0"), GlobalEnum.DateFormatter.yyyymmddhhmmss.rawValue)
        } else {
            startDateMillisecond = ""
        }

        if !(endDate?.isEmpty)! {
            endDateMillisecond = NSDate.millisecond(dateString: String(format: "%@ %@", endDate!, "23:59:59"), GlobalEnum.DateFormatter.yyyymmddhhmmss.rawValue)
        } else {
            endDateMillisecond = ""
        }

        if !(startDate?.isEmpty)! && (endDate?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入结束日期")
            return
        }

        let startMillisecond = Double(NSDate.millisecond(dateString: startDate!, GlobalEnum.DateFormatter.yyyymmdd.rawValue))!
        let endMillisecond = Double(NSDate.millisecond(dateString: endDate!, GlobalEnum.DateFormatter.yyyymmdd.rawValue))!
        if startMillisecond > endMillisecond {
            MBProgressHUD.show(withStatus: "起始日期不能大于结束日期")
            return
        }
        view.endEditing(true)
        pullDownHandle()
    }
}

