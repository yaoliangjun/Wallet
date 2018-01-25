//
//  ExchangeViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/23.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  转至交易所

import UIKit
import MBProgressHUD

class ExchangeViewController: BaseViewController {

    fileprivate var balanceModel: BalanceModel?
    fileprivate var balanceLabel: UILabel?
    fileprivate var addressTextField: UITextField?
    fileprivate var amountTextField: CommonTextFieldView?
    fileprivate var walletPwdTextField: CommonTextFieldView?
    fileprivate var receiverTextField: CommonTextFieldView?
    fileprivate var remarkTextField: CommonTextFieldView?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBalance()
    }

    // MARK: - HTTP
    fileprivate func fetchBalance() {
        let params = ["coinSymbol": AppConstants.appCoinSymbol]
        HomeServices.balance(params: params, showHUD: true, success: { (response) in
            self.balanceModel = response
            let availableBalanceText = NSLocalizedString("可用余额", comment: "")
            let availableBalance = String(format: "%@ %@", availableBalanceText, (response?.useable.defaultDecimalPoint())!)
            let attributedString = NSMutableAttributedString(string: availableBalance)
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: AppConstants.goldColor, range: NSMakeRange(availableBalanceText.count, availableBalance.count - availableBalanceText.count))
            self.balanceLabel!.attributedText = attributedString

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

        let amount = amountTextField?.textFieldText()
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

        let nickName = receiverTextField?.textFieldText()
        let remark = remarkTextField?.textFieldText()

        // 判断是否设置了交易密码
        if !UserInfoManager.hasTradePassword() {
            view.endEditing(true)
            let alertController = UIAlertController(title: NSLocalizedString("设置交易密码", comment: ""), message: NSLocalizedString("您尚未设置交易密码, 是否前往设置?", comment: ""), preferredStyle: .alert, positiveActionTitle: NSLocalizedString("确定", comment: ""), positiveCompletionHandle: { (alert) in
                self.navigationController?.pushViewController(ChangeTradePasswordViewController(), animated: true)

            }, negativeActionTitle: NSLocalizedString("取消", comment: ""), negativeCompletionHandle: nil)
            self.present(alertController, animated: true, completion: nil)
            return
        }

        let tradePassword = walletPwdTextField?.textFieldText()
        if (tradePassword?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入交易密码", comment: ""))
            return
        }

        view.endEditing(true)

        let params = ["coinSymbol": AppConstants.appCoinSymbol, "toAddress": address!, "amount": amount!, "tradePassword": tradePassword!.md5(), "nickName": nickName ?? "", "remark": remark ?? ""]
        TransferServices.transOut(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.show(withStatus: NSLocalizedString("转账成功", comment: ""), completionHandle: {
                self.navigationController?.popViewController(animated: true)
            })

        }) { (error) in

        }
    }

    @objc fileprivate func addContactBtnClick() {

    }

    @objc fileprivate func scanQRCodeBtnClick() {

    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = "转至交易所"

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        // 余额父View
        let balanceView = CommonView()
        contentView.addSubview(balanceView)
        balanceView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(50)
        }

        balanceLabel = UILabel(text: NSLocalizedString("可用余额", comment: ""), textColor: UIColor.white, font: UIFont(14))
        balanceView.addSubview(balanceLabel!)
        balanceLabel!.snp.makeConstraints { (make) in
            make.top.height.equalTo(balanceView)
            make.left.equalTo(balanceView).offset(20)
        }

        // 货币符号
        let coinSymbolView = UIImageView(imageName: "unit50")
        balanceView.addSubview(coinSymbolView)
        coinSymbolView.snp.makeConstraints { (make) in
            make.left.equalTo(balanceLabel!.snp.right).offset(5)
            make.centerY.equalTo(balanceLabel!)
            make.width.height.equalTo(14)
            make.right.lessThanOrEqualTo(balanceView).offset(-10)
        }

        let addressView = CommonView()
        contentView.addSubview(addressView)
        addressView.snp.makeConstraints { (make) in
            make.top.equalTo(balanceView.snp.bottom).offset(15)
            make.left.right.height.equalTo(balanceView)
        }

        // 地址
        addressTextField = UITextField(text: nil, textColor: UIColor.white, placeholder: NSLocalizedString("请输入转至交易所地址或扫码", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14))
        addressView.addSubview(addressTextField!)
        addressTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(addressView).offset(20)
            make.top.bottom.equalTo(addressView)
        }

        // 添加联系人
        let addContactBtn = UIButton(image: UIImage(named: "add_Payee_normal"), highlightedImage: UIImage(named: "add_Payee_press"), target: self, selector: #selector(addContactBtnClick))
        addressView.addSubview(addContactBtn)
        addContactBtn.snp.makeConstraints { (make) in
            make.left.equalTo(addressTextField!.snp.right).offset(10)
            make.centerY.equalTo(addressView)
            make.width.height.equalTo(30)
        }

        // 扫码
        let scanQRCodeBtn = UIButton(image: UIImage(named: "sweep_code_normal"), highlightedImage: UIImage(named: "sweep_code_press"), target: self, selector: #selector(scanQRCodeBtnClick))
        addressView.addSubview(scanQRCodeBtn)
        scanQRCodeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(addContactBtn.snp.right).offset(20)
            make.right.equalTo(addressView).offset(-20)
            make.centerY.equalTo(addressView)
            make.width.equalTo(20)
            make.height.equalTo(18)
        }

        amountTextField = CommonTextFieldView(text: nil, textColor: AppConstants.goldColor, placeholder: NSLocalizedString("请输入转至交易所数额", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(15))
        amountTextField?.textField?.delegate = self
        amountTextField?.setKeyboardType(.decimalPad)
        contentView.addSubview(amountTextField!)
        amountTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp.bottom).offset(15)
            make.left.right.height.equalTo(addressView)
        }

        walletPwdTextField = CommonTextFieldView(text: nil, placeholder: NSLocalizedString("请输入转至交易所密码（交易密码）", comment: ""))
        contentView.addSubview(walletPwdTextField!)
        walletPwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(amountTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(amountTextField!)
        }

        receiverTextField = CommonTextFieldView(text: nil, placeholder: NSLocalizedString("请输入收款人昵称或手机号（非必填）", comment: ""))
        contentView.addSubview(receiverTextField!)
        receiverTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(walletPwdTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(walletPwdTextField!);
        }

        remarkTextField = CommonTextFieldView(text: nil, placeholder: NSLocalizedString("备注", comment: ""))
        contentView.addSubview(remarkTextField!)
        remarkTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(receiverTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(receiverTextField!);
        }

        let confirmBtn = CommonButton(title: NSLocalizedString("确定", comment: ""), target: self, selector: #selector(confirmBtnClick))
        contentView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.top.equalTo(remarkTextField!.snp.bottom).offset(60)
        }

        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(confirmBtn.snp.bottom).offset(40)
        }
    }
}

extension ExchangeViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^[0-9]*((\\.|,)[0-9]{0,4})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        return numberOfMatches != 0
    }
}
