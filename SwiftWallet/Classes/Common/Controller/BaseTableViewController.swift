//
//  BaseTableViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/11/27.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  UITableView基类

import UIKit
import MJRefresh

// 下拉刷新状态
enum RefreshStatus {
    case pullDown
    case pullUp
}

class BaseTableViewController: BaseViewController {

    var tableView: UITableView? = nil;
    var refreshStatus: RefreshStatus = .pullDown
    var pageNumber = 1 // 默认页码:第1页
    var pageCount = 15 // 默认每页显示条数

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 创建UITableView
    func createTableView(frame: CGRect, style: UITableViewStyle) -> UITableView {
        let tableView = UITableView(frame: frame, style: style)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = GlobalConstants.backgroundColor
        return tableView
    }

    func createTableView(frame: CGRect, delegate: AnyObject?, style: UITableViewStyle) -> UITableView {
        let tableView = self.createTableView(delegate: delegate, style: style)
        tableView.frame = frame
        return tableView
    }

    func createTableView(style: UITableViewStyle) -> UITableView {
        let tableView = createTableView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.tableViewHeight), style: style)
        return tableView
    }

    func createTableView(style: UITableViewStyle, needRefresh: Bool) -> UITableView {
        let tableView = self.createTableView(style: style)
        if needRefresh {
            addRefreshComponentsWithTableView(tableView: tableView)
        }
        return tableView
    }

    func createTableView(delegate: AnyObject?, style: UITableViewStyle) -> UITableView {
        let tableView = self.createTableView(delegate: delegate, style: style, needRefresh: false)
        return tableView
    }

    func createTableView(delegate: AnyObject?, style: UITableViewStyle, needRefresh: Bool) -> UITableView {
        let tableView = self.createTableView(style: style)
        tableView.delegate = delegate as? UITableViewDelegate
        tableView.dataSource = delegate as? UITableViewDataSource
        if needRefresh {
            addRefreshComponentsWithTableView(tableView: tableView)
        }
        return tableView
    }

    func addRefreshComponentsWithTableView(tableView: UITableView) -> () {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownToRefresh))
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("松开刷新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        header?.stateLabel.textColor = UIColor.white
        tableView.mj_header = header

        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(pullUpToRefresh))
        footer?.setTitle("下拉刷新", for: .idle)
        footer?.setTitle("松开刷新", for: .pulling)
        footer?.setTitle("加载中...", for: .refreshing)
        footer?.stateLabel.textColor = UIColor.white
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
    }

    /** 下拉处理: 子类重写该方法,请求数据 */
    func pullDownHandle() -> () {

    }

    /** 上拉处理: 子类重写该方法,请求数据 */
    func pullUpHandle() -> () {

    }

    @objc private func pullDownToRefresh() -> () {
        refreshStatus = .pullDown
        endRefreshingHeader()
        pullDownHandle()
    }

    @objc private func pullUpToRefresh() -> () {
        refreshStatus = .pullUp
        endRefreshingFooter()
        pullUpHandle()
    }

    fileprivate func endRefreshingHeader() -> () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView?.mj_header.endRefreshing()
        }
    }

    fileprivate func endRefreshingFooter() -> () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView?.mj_footer.endRefreshing()
        }
    }

    func showHeaderView(_ isShowHeaderView: Bool) {
        tableView?.mj_header.isHidden = !isShowHeaderView
    }

    func showFooterView(_ isShowFooterView: Bool) {
        tableView?.mj_footer.isHidden = !isShowFooterView
    }
}

// MARK: - extension
extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
}
