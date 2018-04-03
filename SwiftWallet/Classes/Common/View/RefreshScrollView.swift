//
//  RefreshScrollView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/4/3.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  有下拉刷新功能的UIScrollView

import UIKit
import MJRefresh

class RefreshScrollView: UIScrollView {

    // 下拉回调
    var pullDownHandle: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addRefreshComponent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func addRefreshComponent() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownToRefresh))
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("松开刷新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        header?.stateLabel.textColor = UIColor.white
        header?.activityIndicatorViewStyle = .white
        self.mj_header = header
    }

    // 下拉刷新回调
    @objc fileprivate func pullDownToRefresh() {
        endRefreshingHeader()
        if pullDownHandle != nil {
            pullDownHandle!()
        }
    }

    // 结束刷新
    @objc fileprivate func endRefreshingHeader() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.mj_header.endRefreshing()
        }
    }
}
