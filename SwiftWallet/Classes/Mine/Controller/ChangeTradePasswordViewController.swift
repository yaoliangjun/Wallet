//
//  ChangeTradePasswordViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import MBProgressHUD

class ChangeTradePasswordViewController: BaseViewController, UITextFieldDelegate {

    fileprivate var pwdTextField: CommonTextField?
    fileprivate var repeatPwdTextField: CommonTextField?
    fileprivate var verifyCodeTextField: CommonTextField?
    fileprivate var verifyCodeBtn: UIButton?
    fileprivate var showPassword: Bool = false
    fileprivate var showRepeatPassword: Bool = false
    fileprivate var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // 明文切换密文后避免被清空
        var toBeStr = textField.text
        let rag = toBeStr?.toRange(range)
        toBeStr = toBeStr?.replacingCharacters(in: rag!, with: string)

        if textField == pwdTextField &&  textField.isSecureTextEntry {
            textField.text = toBeStr
            return false

        } else if textField == repeatPwdTextField &&  textField.isSecureTextEntry {
            textField.text = toBeStr
            return false
        }

        return true
    }

    // MARK: - Private Method
    @objc fileprivate func confirmBtnClick() {
        let password = pwdTextField?.text
        let repeatPassword = repeatPwdTextField?.text
        let verifyCode = verifyCodeTextField?.text

        if (password?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入6-16位字符与数字的交易密码", comment: ""))
            return
        }

        if !(password?.validPasswordFormatter())! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入6-16位字符与数字的交易密码", comment: ""))
            return
        }

        if (repeatPassword?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请再次输入交易密码", comment: ""))
            return
        }

        if !(repeatPassword?.validPasswordFormatter())! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入6-16位字符与数字的交易密码", comment: ""))
            return
        }

        if password != repeatPassword {
            MBProgressHUD.show(withStatus: NSLocalizedString("两次输入的密码不一致", comment: ""))
            return
        }

        if (verifyCode?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入短信验证码", comment: ""))
            return
        }

        view.endEditing(true)

        let params = ["newTradePassword": password!.md5(), "captcha": verifyCode!]
        MineServices.changeTradePassword(params: params, showHUD: true, success: { (response) in
            var status = NSLocalizedString("设置成功", comment: "")
            if UserInfoManager.hasTradePassword() {
                status = NSLocalizedString("修改成功", comment: "")
            }

            MBProgressHUD.showShort(withStatus: status, completionHandle: {
                // 标识已经设置过交易密码
                UserInfoManager.saveHasTradePassword(true)
                self.navigationController?.popViewController(animated: true)
            })
        }) { (error) in

        }
    }

    // 获取验证码
    @objc func verifyCodeBtnClick() {
        let password = pwdTextField?.text
        let repeatPassword = repeatPwdTextField?.text

        if (password?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入交易密码")
            return
        }

        if !(password?.validPasswordFormatter())! {
            MBProgressHUD.show(withStatus: "请输入6-16位字符与数字的交易密码")
            return
        }

        if (repeatPassword?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请再次输入交易密码")
            return
        }

        if !(repeatPassword?.validPasswordFormatter())! {
            MBProgressHUD.show(withStatus: "请输入6-16位字符与数字的交易密码")
            return
        }

        if password != repeatPassword {
            MBProgressHUD.show(withStatus: "两次输入的密码不一致")
            return
        }

        view.endEditing(true)

        MineServices.tradeVericodeWithParams(params: nil, showHUD: true, success: { (response) in
            // 保存点击时候的时间
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: AppConstants.startGetVerifyCode)
            UserDefaults.standard.synchronize()

            self.verifyCodeCountdown()
            self.verifyCodeBtn?.isEnabled = false
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.verifyCodeCountdown), userInfo: nil, repeats: true)

            MBProgressHUD.show(withStatus: NSLocalizedString("验证码已发送", comment: ""))
            
        }) { (error) in

        }
    }

    // 获取验证码倒计时
    @objc func verifyCodeCountdown() {
        let countdownSecond = 60.0
        let startTimeInterval = UserDefaults.standard.double(forKey: AppConstants.startGetVerifyCode)
        if startTimeInterval + countdownSecond > Date().timeIntervalSince1970 {
            let countdownInterval = Int(startTimeInterval + countdownSecond - Date().timeIntervalSince1970)
            verifyCodeBtn?.setTitle(String(countdownInterval), for: .normal)

        } else {
            verifyCodeBtn?.setTitle(NSLocalizedString("获取验证码", comment: ""), for: .normal)
            verifyCodeBtn?.isEnabled = true
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc fileprivate func eyeBtnClick(btn: UIButton) {
        let tag = btn.tag
        if tag == 100 {
            // 1.避免明文和密文切换后光标位置偏移
            pwdTextField?.isEnabled = false;
            if showPassword {
                btn.setImage(UIImage(named: "login_show_password"), for: .normal)
                pwdTextField?.isSecureTextEntry = true
            } else {
                btn.setImage(UIImage(named: "login_hide_password"), for: .normal)
                pwdTextField?.isSecureTextEntry = false
            }

            showPassword = !showPassword
            // 2.避免明文和密文切换后光标位置偏移
            pwdTextField?.isEnabled = true;
            pwdTextField?.becomeFirstResponder()

        } else if tag == 200 {
            // 1.避免明文和密文切换后光标位置偏移
            repeatPwdTextField?.isEnabled = false;
            if showRepeatPassword {
                btn.setImage(UIImage(named: "login_show_password"), for: .normal)
                repeatPwdTextField?.isSecureTextEntry = true
            } else {
                btn.setImage(UIImage(named: "login_hide_password"), for: .normal)
                repeatPwdTextField?.isSecureTextEntry = false
            }

            showRepeatPassword = !showRepeatPassword
            // 2.避免明文和密文切换后光标位置偏移
            repeatPwdTextField?.isEnabled = true;
            repeatPwdTextField?.becomeFirstResponder()
        }
    }

    fileprivate func rightView(tag: Int) -> UIView {
        let btn = UIButton(image: UIImage(named: "login_show_password"), highlightedImage: UIImage(named: "login_show_password"), target: self, selector: #selector(eyeBtnClick))
        btn.tag = tag
        btn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        rightView.addSubview(btn)

        return rightView
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = NSLocalizedString("设置交易密码", comment: "")
        if UserInfoManager.hasTradePassword() {
            title = NSLocalizedString("修改交易密码", comment: "")
        }

        let pwdRightView = rightView(tag: 100)
        pwdTextField = CommonTextField(text: nil, placeholder: NSLocalizedString("请输入6-16位字符与数字的交易密码", comment: ""), rightView: pwdRightView, rightViewMode: .always)
        pwdTextField?.delegate = self
        pwdTextField?.isSecureTextEntry = true
        self.view.addSubview(pwdTextField!)
        pwdTextField!.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }

        let pepeatPwdRightView = rightView(tag: 200)
        repeatPwdTextField = CommonTextField(text: nil, placeholder: NSLocalizedString("请再次输入设置的交易密码", comment: ""), rightView: pepeatPwdRightView, rightViewMode: .always)
        repeatPwdTextField?.delegate = self
        repeatPwdTextField?.isSecureTextEntry = true
        self.view.addSubview(repeatPwdTextField!)
        repeatPwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(pwdTextField!.snp.bottom).offset(15)
            make.left.right.equalTo(self.view)
            make.height.equalTo(pwdTextField!)
        }

        // 获取验证码
        verifyCodeBtn = UIButton(title: NSLocalizedString("获取验证码", comment: ""), titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont(12), backgroundColor: AppConstants.grayColor, borderWidth: 0, borderColor: nil, cornerRadius: 4, target: self, selector: #selector(verifyCodeBtnClick))
        verifyCodeBtn?.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
        let verifyCodeRightView = UIView(frame: CGRect(x: 0, y: 0, width: 105, height: 35))
        verifyCodeRightView.addSubview(verifyCodeBtn!)

        verifyCodeTextField = CommonTextField(text: nil, placeholder: NSLocalizedString("请输入短信验证码", comment: ""), rightView: verifyCodeRightView, rightViewMode: .always)
        verifyCodeTextField?.delegate = self
        self.view.addSubview(verifyCodeTextField!)
        verifyCodeTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPwdTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(repeatPwdTextField!)
        }

        let confirmBtn = CommonButton(title: NSLocalizedString("确定", comment: ""), target: self, selector: #selector(confirmBtnClick))
        self.view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50);
            make.left.equalTo(self.view).offset(30);
            make.right.equalTo(self.view).offset(-30);
            make.top.equalTo(verifyCodeTextField!.snp.bottom).offset(60);
        }
    }
}

