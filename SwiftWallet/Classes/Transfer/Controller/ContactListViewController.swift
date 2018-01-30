//
//  ContactListViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/30.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  联系人列表

import UIKit

class ContactListViewController: BaseTableViewController {

    fileprivate var searchController: UISearchController?
    fileprivate var selectedContactModel: ContactModel?
    var didSelectedContactBlock: ((_ contactModel: ContactModel) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContactList()
    }

    // MARK: - HTTP
    fileprivate func fetchContactList() {
        let params = ["coinSymbol": AppConstants.appCoinSymbol]
        TransferServices.contactList(params: params, showHUD: true, success: { (response) in
            self.contactArray = response!
            self.placeholderView?.isHidden = self.contactArray.count > 0
            self.tableView?.reloadData()

        }) { (error) in

        }
    }

    // MARK: - Private Method
    @objc fileprivate func addContactBtnClick() {
        navigationController?.pushViewController(ContactListViewController(), animated: true)
    }

    fileprivate func showDeleteAlertView() {
        let alertController = UIAlertController(title: "", message: NSLocalizedString("是否要删除该联系人？", comment: ""), preferredStyle: .actionSheet, positiveActionTitle: NSLocalizedString("删除", comment: ""), positiveCompletionHandle: { (alert) in

        }, negativeActionTitle: NSLocalizedString("取消", comment: "")) { (alert) in

        }
        self.present(alertController, animated: true, completion: nil)
        self.tableView?.endEditing(true)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = NSLocalizedString("联系人列表", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "add_contact_normal", target: self, selector: #selector(addContactBtnClick))
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
        tableView = createTableView(delegate: self, style: .grouped)
        view.addSubview(tableView!)

        placeholderView = PlaceholderView(frame: CGRect(x: 0, y: 190, width: 115, height: 70), superView: tableView!, placeholder: NSLocalizedString("暂无联系人", comment: ""), placeholderImageName: "home_no_history")

        // 创建UISearchController, 使用当前控制器来展示结果
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 55)
        searchController?.hidesNavigationBarDuringPresentation = true // // 是否隐藏导航栏
        searchController?.searchResultsUpdater = self // // 设置结果更新代理
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.searchBar.backgroundImage = UIImage.createImage(color: GlobalConstants.backgroundColor)
        tableView?.tableHeaderView = searchController?.searchBar
    }

    fileprivate lazy var resultArray: [ContactModel] = {
        var resultArray = [ContactModel]()
        return resultArray
    }()

    fileprivate lazy var contactArray: [ContactModel] = {
        var contactArray = [ContactModel]()
        return contactArray
    }()
}

// MARK: - Extension
extension ContactListViewController: UISearchResultsUpdating {

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (searchController?.isActive)! {
            return resultArray.count
        }
        return contactArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactCell.cellWithTableView(tableView) as! ContactCell
        let contactModel: ContactModel?
        if (searchController?.isActive)! {
            contactModel = resultArray[indexPath.section]

        } else {
            contactModel = contactArray[indexPath.section]
        }
        cell.setupModel(contactModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let contactModel: ContactModel?
        if (searchController?.isActive)! {
            contactModel = resultArray[indexPath.section]

        } else {
            contactModel = contactArray[indexPath.section]
        }

        if let block = didSelectedContactBlock {
            block(contactModel!)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
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
        return 60;
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let updateAction = UITableViewRowAction(style: .default, title: NSLocalizedString("修改备注", comment: "")) { (action, indexPath) in
            self.selectedContactModel = self.contactArray[indexPath.section]

            self.tableView?.endEditing(true)
        }
        updateAction.backgroundColor = UIColor.orange

        let deleteAction = UITableViewRowAction(style: .default, title: NSLocalizedString("删除", comment: "")) { (action, indexPath) in
            self.selectedContactModel = self.contactArray[indexPath.section]
            self.showDeleteAlertView()
        }
        deleteAction.backgroundColor = UIColor.red

        return [deleteAction, updateAction]
    }
//    - (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    UITableViewRowAction *updateRemarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"修改备注", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    _selectedContactModel = _contactArray[indexPath.section];
//    [[self alertView] show];
//
//    NSString *nickname = _selectedContactModel.nickName;
//    _nicknameTextField.text = nickname;
//
//    }];
//    updateRemarkAction.backgroundColor = kHexRGB(0x43424A);
//
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"删除", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    _selectedContactModel = _contactArray[indexPath.section];;
//    [self showDeleteAlertView];
//
//    }];
//    deleteAction.backgroundColor = kRedTextColor;
//
//    return @[deleteAction, updateRemarkAction];
//    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let filterString = searchController.searchBar.text
        resultArray = contactArray.filter { (contactModel: ContactModel) -> Bool in
            return (contactModel.nickName?.contains(filterString!))! || (contactModel.address?.contains(filterString!))!
        }
        tableView?.reloadData()
    }
}

