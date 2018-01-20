//
//  DistrictNumViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/11.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  选择区号页面

import UIKit

class DistrictNumViewController: BaseTableViewController {

    var districtArray: [DistrictModel]?
    var resultArray: [DistrictModel]?
    var searchController: UISearchController?

    typealias SelectedDistrictNumBlock = (_ districtModel: DistrictModel?) -> ()
    var didSelectedDistrictNumBlock: SelectedDistrictNumBlock!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage.createImage(color: GlobalConstants.navigationBarColor), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.createImage(color: GlobalConstants.navigationBarColor)
    }

    override func setupSubViews() {
        title = NSLocalizedString("选择国家/地区", comment: "")
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true

        tableView = createTableView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.tableViewHeight + GlobalConstants.tabBarHeight), delegate: self, style: .grouped)
        view.addSubview(tableView!)

        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.sizeToFit()
        searchController?.dimsBackgroundDuringPresentation = false // 因为在当前控制器展示结果, 所以不需要这个透明视图
        searchController?.hidesNavigationBarDuringPresentation = true // 是否隐藏导航栏
        searchController?.searchResultsUpdater = self // 设置结果更新代理
        searchController?.searchBar.backgroundImage = UIImage.createImage(color: GlobalConstants.navigationBarColor)
        tableView?.tableHeaderView = searchController?.searchBar
    }
}

extension DistrictNumViewController: UISearchResultsUpdating {

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (searchController?.isActive)! {
            return (resultArray?.count)!
        }

        return (districtArray?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DistrictNumCell.cellWithTableView(tableView: tableView) as! DistrictNumCell
        var model: DistrictModel? = nil
        if (searchController?.isActive)! {
            model = resultArray![indexPath.section]
        } else {
            model = districtArray![indexPath.section]
        }
        cell.setupDistrictModel(districtModel: model!)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var model: DistrictModel? = nil
        if (searchController?.isActive)! {
            model = resultArray![indexPath.section]
        } else {
            model = districtArray![indexPath.section]
        }

        if let block = didSelectedDistrictNumBlock {
            block(model)
        }
        navigationController?.popViewController(animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader;
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let filterString = searchController.searchBar.text
        resultArray = districtArray?.filter( { (districtModel: DistrictModel) -> Bool in
            return (districtModel.chineseName?.contains(filterString!))! ||      (districtModel.nationalName?.contains(filterString!))! || (districtModel.code?.contains(filterString!))!
        })

        tableView?.reloadData()
    }
}

