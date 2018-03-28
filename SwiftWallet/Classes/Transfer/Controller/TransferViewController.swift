//
//  TransferViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/11.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import MBProgressHUD

class TransferViewController: BaseTableViewController {

    fileprivate var transOutBtn: UIButton?
    fileprivate var transInBtn: UIButton?
    fileprivate var transOutTriangleImageView: UIImageView?
    fileprivate var transInTriangleImageView: UIImageView?
    fileprivate var balanceLabel: UILabel?
    fileprivate var addressTextField: UITextField?
    fileprivate var amountTextField: UITextField?
    fileprivate var walletPwdTextField: UITextField?
    fileprivate var receiverTextField: UITextField?
    fileprivate var remarkTextField: UITextField?
    fileprivate var copyingBtn: CommonButton?
    fileprivate var downloadBtn: CommonButton?
    fileprivate var balanceModel: BalanceModel?
    fileprivate var qrCodeView: QRCodeView?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBalance()
        fetchWalletAddress()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - HTTP
    fileprivate func fetchBalance() {
        let params = ["coinSymbol": AppConstants.appCoinSymbol]
        HomeServices.balance(params: params, showHUD: true, success: { (response) in
            self.balanceModel = response
            self.balanceLabel?.text = response?.useable.defaultDecimalPoint()

        }) { (error) in

        }
    }

    fileprivate func fetchWalletAddress() {
        let params = ["coinSymbol": AppConstants.appCoinSymbol]
        HomeServices.walletAddress(params: params, showHUD: true, success: { (response) in
            self.qrCodeView?.setupAddress(address: response?.address)

        }) { (error) in
            
        }
    }
    
    // MARK: - Private Method
    @objc fileprivate func confirmBtnClick() {
        let address = addressTextField?.text
        if (address?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入转至交易所地址或扫码", comment: ""))
            return
        }

        let amount = amountTextField?.text
        if (amount?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入转至交易所数额", comment: ""))
            return
        }

        if (amount?.starts(with: "."))! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入合法的数额", comment: ""))
            return
        }

        if Double(amount!)! > Double((balanceModel?.useable)!)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("余额不足", comment: ""))
            return
        }

        // 判断是否设置了交易密码
        if !UserInfoManager.hasTradePassword() {
            view.endEditing(true)
            let alertController = UIAlertController(title: NSLocalizedString("设置交易密码", comment: ""), message: NSLocalizedString("您尚未设置交易密码, 是否前往设置?", comment: ""), preferredStyle: .alert, positiveActionTitle: NSLocalizedString("确定", comment: ""), positiveCompletionHandle: { (alert) in
                self.navigationController?.pushViewController(ChangeTradePasswordViewController(), animated: true)

            }, negativeActionTitle: NSLocalizedString("取消", comment: ""), negativeCompletionHandle: nil)
            self.present(alertController, animated: true, completion: nil)
            return
        }

        let tradePassword = walletPwdTextField?.text
        if (tradePassword?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入交易密码", comment: ""))
            return
        }

        let nickName = receiverTextField?.text
        let remark = remarkTextField?.text
        view.endEditing(true)

        let params = ["coinSymbol": AppConstants.appCoinSymbol, "toAddress": address!, "amount": amount!, "tradePassword": tradePassword!.md5(), "nickName": nickName ?? "", "remark": remark ?? ""]
        TransferServices.transOut(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.show(withStatus: NSLocalizedString("转账成功", comment: ""), completionHandle: {
                self.addressTextField?.text = nil
                self.amountTextField?.text = nil
                self.walletPwdTextField?.text = nil
                self.receiverTextField?.text = nil
                self.remarkTextField?.text = nil
            })

        }) { (error) in

        }
    }

    @objc fileprivate func transBtnClick(btn: UIButton) {
        let tag = btn.tag
        if tag == 100 {
            setTransBtnSelected(tag)
            scrollView.contentOffset = CGPoint(x: 0, y: 0)

        } else if tag == 200 {
            setTransBtnSelected(tag)
            scrollView.contentOffset = CGPoint(x: GlobalConstants.screenWidth, y: 0)
        }
    }

    @objc fileprivate func addContactBtnClick() {
        let contactListVC = ContactListViewController()
        contactListVC.didSelectedContactBlock = { (contactModel: ContactModel) in
            Logger(contactModel.nickName)
            self.addressTextField?.text = contactModel.address
            let nickName = contactModel.nickName
            if !(nickName?.isEmpty)! {
                self.receiverTextField?.text = nickName
            }
        }
        navigationController?.pushViewController(contactListVC, animated: true)
    }

    @objc fileprivate func scanQRCodeBtnClick() {
        let scanVC = ScanViewController()
        scanVC.didScanSuccessClosure = { (result: String?) in
            self.addressTextField?.text = result
        }
        navigationController?.pushViewController(scanVC, animated: true)
    }

    @objc fileprivate func copyBtnClick() {

    }

    @objc fileprivate func downloadBtnClick() {

    }

    fileprivate func setTransBtnSelected(_ tag: Int) {

        if tag == 100 {
            transOutBtn?.setTitleColor(AppConstants.goldColor, for: .normal)
            transOutBtn?.setImage(UIImage(named: "go_to_icon_press"), for: .normal)
            transInBtn?.setTitleColor(UIColor.white, for: .normal)
            transInBtn?.setImage(UIImage(named: "transfer_to_icon_normal"), for: .normal)
            transInTriangleImageView?.isHidden = true
            transOutTriangleImageView?.isHidden = false

        } else if tag == 200 {
            transInBtn?.setTitleColor(AppConstants.goldColor, for: .normal)
            transInBtn?.setImage(UIImage(named: "transfer_to_icon_press"), for: .normal)
            transOutBtn?.setTitleColor(UIColor.white, for: .normal)
            transOutBtn?.setImage(UIImage(named: "go_to_icon_normal"), for: .normal)
            transOutTriangleImageView?.isHidden = true
            transInTriangleImageView?.isHidden = false
        }
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = NSLocalizedString("转账", comment: "")
        tableView = createTableView(delegate: self, style: .plain)
        tableView!.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.tableViewHeight - GlobalConstants.tabBarHeight)
        tableView!.allowsSelection = false
        tableView!.tableHeaderView = tableHeaderView
        view.addSubview(tableView!)
    }

    fileprivate lazy var tableHeaderView: UIView = {

        var bannerViewHeight: CGFloat = 205
        if UIDevice.matchSize(4.7) {
            bannerViewHeight = 195

        } else if UIDevice.matchSize(4) || UIDevice.matchSize(3.5) {
            bannerViewHeight = 160
        }

        var tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: bannerViewHeight))
        let bannerImageView = UIImageView(imageName: "transfer_banner")
        tableHeaderView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableHeaderView)
        }

        return tableHeaderView
    }()

    // 转入转出View
    fileprivate lazy var sectionHeaderView: UIView = {

        var sectionHeaderView = UIImageView(imageName: "trans_background")
        sectionHeaderView.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 60)
        sectionHeaderView.isUserInteractionEnabled = true

        // 转出
        transOutBtn = UIButton(title: "转出", titleColor: AppConstants.goldColor, highlightedTitleColor: AppConstants.goldColor, font: UIFont(16), target: self, selector: #selector(transBtnClick))
        transOutBtn?.tag = 100
        transOutBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        transOutBtn?.setImage(UIImage(named: "go_to_icon_press"), for: .normal)
        transOutBtn?.setImage(UIImage(named: "go_to_icon_press"), for: .highlighted)
        sectionHeaderView.addSubview(transOutBtn!)
        transOutBtn!.snp.makeConstraints { (make) in
            make.top.height.centerY.equalTo(sectionHeaderView)
            make.left.equalTo(sectionHeaderView).offset(20)
        }

        // 转出小三角
        transOutTriangleImageView = UIImageView(imageName: "triangle")
        sectionHeaderView.addSubview(transOutTriangleImageView!)
        transOutTriangleImageView!.snp.makeConstraints { (make) in
            make.centerX.equalTo(transOutBtn!)
            make.bottom.equalTo(sectionHeaderView.snp.bottom).offset(-6)
            make.width.equalTo(12)
            make.height.equalTo(10)
        }

        // 转入
        transInBtn = UIButton(title: "转入", titleColor:UIColor.white, highlightedTitleColor: AppConstants.goldColor, font: UIFont(16), target: self, selector: #selector(transBtnClick))
        transInBtn?.tag = 200
        transInBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        transInBtn?.setImage(UIImage(named: "transfer_to_icon_normal"), for: .normal)
        transInBtn?.setImage(UIImage(named: "transfer_to_icon_normal"), for: .highlighted)
        sectionHeaderView.addSubview(transInBtn!)
        transInBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(transOutBtn!.snp.right).offset(20)
            make.width.equalTo(transOutBtn!)
            make.centerY.height.top.equalTo(transOutBtn!)
            make.right.equalTo(sectionHeaderView).offset(-20)
        }

        // 转入小三角
        transInTriangleImageView = UIImageView(imageName: "triangle")
        transInTriangleImageView?.isHidden = true
        sectionHeaderView.addSubview(transInTriangleImageView!)
        transInTriangleImageView!.snp.makeConstraints { (make) in
            make.centerX.equalTo(transInBtn!)
            make.bottom.equalTo(sectionHeaderView.snp.bottom).offset(-6)
            make.width.equalTo(12)
            make.height.equalTo(10)
        }
        return sectionHeaderView
    }()

    fileprivate lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 470))
        scrollView.backgroundColor = GlobalConstants.backgroundColor
        scrollView.bounces = false
        scrollView.isScrollEnabled = false
        scrollView.isDirectionalLockEnabled = true        // 设置方向锁定(即:同一时间只允许向一个方向滚动)
        scrollView.showsVerticalScrollIndicator = false   // 设置是否显示垂直滚动条
        scrollView.showsHorizontalScrollIndicator = false // 设置是否显示水平滚动条
        scrollView.contentSize = CGSize(width: GlobalConstants.screenWidth, height: 470)

        // 转出父View
        let transOutContentView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 470))
        scrollView.addSubview(transOutContentView)

        let balanceText = UILabel(text: NSLocalizedString("可用余额: ", comment: ""), textColor: UIColor.white, font: UIFont(12))
        transOutContentView.addSubview(balanceText)
        balanceText.snp.makeConstraints { (make) in
            make.top.left.equalTo(transOutContentView).offset(20)
            make.width.lessThanOrEqualTo(130)
            make.height.equalTo(20)
        }

        balanceLabel = UILabel(text: nil, textColor: AppConstants.goldColor, font: UIFont(12))
        transOutContentView.addSubview(balanceLabel!)
        balanceLabel!.snp.makeConstraints { (make) in
            make.top.height.equalTo(balanceText)
            make.left.equalTo(balanceText.snp.right)
        }

        // 货币符号
        let coinSymbolView = UIImageView(imageName: "unit50")
        transOutContentView.addSubview(coinSymbolView)
        coinSymbolView.snp.makeConstraints { (make) in
            make.left.equalTo(balanceLabel!.snp.right).offset(5)
            make.centerY.equalTo(balanceLabel!)
            make.width.height.equalTo(13)
            make.right.lessThanOrEqualTo(transOutContentView).offset(-10)
        }

        // 添加联系人
        let addContactBtn = UIButton(image: UIImage(named: "add_Payee_normal"), highlightedImage: UIImage(named: "add_Payee_press"), target: self, selector: #selector(addContactBtnClick))
        addContactBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        // 地址
        let addressView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        addressTextField = createTextField(placeholder: NSLocalizedString("请输入收款人地址或点击添加收款人", comment: ""), leftView: addressView, rightView: addContactBtn)
        transOutContentView.addSubview(addressTextField!)
        addressTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(transOutContentView).offset(20)
            make.top.equalTo(balanceText.snp.bottom).offset(20)
            make.height.equalTo(40)
        }

        // 扫码
        let scanQRCodeBtn = UIButton(image: UIImage(named: "sweep_code_normal"), highlightedImage: UIImage(named: "sweep_code_press"), target: self, selector: #selector(scanQRCodeBtnClick))
        transOutContentView.addSubview(scanQRCodeBtn)
        scanQRCodeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(addressTextField!.snp.right).offset(20)
            make.right.equalTo(transOutContentView).offset(-20)
            make.centerY.equalTo(addressTextField!)
            make.width.equalTo(25)
            make.height.equalTo(23)
        }

        let amountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        amountTextField = createTextField(placeholder: NSLocalizedString("请输入数额", comment: ""), leftView: amountLeftView, rightView: nil)
        amountTextField?.delegate = self
        amountTextField?.keyboardType = .decimalPad
        transOutContentView.addSubview(amountTextField!)
        amountTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextField!.snp.bottom).offset(15)
            make.left.height.equalTo(addressTextField!)
            make.right.equalTo(transOutContentView).offset(-20)
        }

        let walletPwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        walletPwdTextField = createTextField(placeholder: NSLocalizedString("请输入转账密码（交易密码）", comment: ""), leftView: walletPwdLeftView, rightView: nil)
        transOutContentView.addSubview(walletPwdTextField!)
        walletPwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(amountTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(amountTextField!)
        }

        let receiverLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        receiverTextField = createTextField(placeholder: NSLocalizedString("请输入收款人昵称或手机号（非必填）", comment: ""), leftView: receiverLeftView, rightView: nil)
        transOutContentView.addSubview(receiverTextField!)
        receiverTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(walletPwdTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(walletPwdTextField!)
        }

        let remarkLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        remarkTextField = createTextField(placeholder: NSLocalizedString("备注", comment: ""), leftView: remarkLeftView, rightView: nil)
        transOutContentView.addSubview(remarkTextField!)
        remarkTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(receiverTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(receiverTextField!)
        }

        // 确认转账
        let confirmBtn = CommonButton(title: NSLocalizedString("确认转账", comment: ""), target: self, selector: #selector(confirmBtnClick))
        transOutContentView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.left.right.equalTo(remarkTextField!)
            make.top.equalTo(remarkTextField!.snp.bottom).offset(60)
        }

        // 转入父View
        let transInContentView = UIView(frame: CGRect(x: GlobalConstants.screenWidth, y: 0, width: GlobalConstants.screenWidth, height: 360))
        scrollView.addSubview(transInContentView)

        // 二维码View
        qrCodeView = QRCodeView()
        transInContentView.addSubview(qrCodeView!)
        qrCodeView!.snp.makeConstraints { (make) in
            make.top.equalTo(transInContentView).offset(35)
            make.centerX.equalTo(transInContentView)
            make.width.height.equalTo(235)
        }

        // 复制地址
        copyingBtn = CommonButton(title: NSLocalizedString("复制地址", comment: ""), target: self, selector: #selector(copyBtnClick))
        transInContentView.addSubview(copyingBtn!)
        copyingBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(qrCodeView!)
            make.top.equalTo(qrCodeView!.snp.bottom).offset(30)
            make.height.equalTo(45)
            make.width.equalTo(100)
        }

        // 下载地址
        downloadBtn = CommonButton(title: NSLocalizedString("下载地址", comment: ""), target: self, selector: #selector(downloadBtnClick))
        transInContentView.addSubview(downloadBtn!)
        downloadBtn!.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(copyingBtn!)
            make.right.equalTo(qrCodeView!.snp.right)
        }

        return scrollView
    }()

    fileprivate func createTextField(placeholder: String?, leftView: UIView?, rightView: UIView?) -> UITextField {
        let textField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: placeholder, placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 6, leftView: leftView, rightView: rightView)
        return textField
    }
}

// MARK: - Extension
extension TransferViewController: UITextFieldDelegate {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommonTableViewCell.cellWithTableView(tableView)
        cell.contentView.addSubview(scrollView)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }

    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^[0-9]*((\\.|,)[0-9]{0,4})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        return numberOfMatches != 0
    }
}

