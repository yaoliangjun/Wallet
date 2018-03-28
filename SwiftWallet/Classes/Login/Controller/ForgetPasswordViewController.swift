//
//  ForgetPasswordViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/10.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import MBProgressHUD

class ForgetPasswordViewController: BaseViewController {

    fileprivate var accountTextField: UITextField?
    fileprivate var verifyCodeTextField: UITextField?
    fileprivate var pwdTextField: UITextField?
    fileprivate var rePwdTextField: UITextField?
    fileprivate var timer: Timer?
    fileprivate var verifyCodeBtn: UIButton?
    fileprivate var districtArray: [DistrictModel]?
    fileprivate var currentDistrict: String = CommonUtils.currentRegionCode() // 默认区域 CN
    fileprivate var currentDistrictCode: String = "86" // 默认区号 86
    fileprivate var imageBtn: ImageButton?
    fileprivate var showPassword = false
    fileprivate var showRepeatPassword = false

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDistrictNum()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Private Method
    // 获取区号
    func fetchDistrictNum() {
        LoginServices.districtNum(params: [:], showHUD: true, success: { (response) in
            guard let districtArray = response else {
                return
            }

            self.districtArray = districtArray
            for model in districtArray {
                let abbre = model.abbre
                if !(abbre?.isEmpty)! && (abbre!.contains(self.currentDistrict)) {
                    self.currentDistrictCode = model.code!
                }
            }

        }) { (error) in

        }
    }

    // 确定找回密码
    @objc func confirmBtnClick() {
        let account = accountTextField?.text
        let verifyCode = verifyCodeTextField?.text
        let pwd = pwdTextField?.text
        let rePwd = rePwdTextField?.text

        if (account?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入手机号", comment: ""))
            return
        }

        if (verifyCode?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入验证码", comment: ""))
            return
        }

        if (!(pwd?.validPasswordFormatter())!) {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入6-16位数字和字符的登录密码", comment: ""))
            return
        }

        if (rePwd?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请再次输入登录密码", comment: ""))
            return
        }

        if (!(rePwd?.validPasswordFormatter())!) {
            MBProgressHUD.show(withStatus: NSLocalizedString("请再次输入6-16位数字和字符的登录密码", comment: ""))
            return
        }

        if pwd != rePwd {
            MBProgressHUD.show(withStatus: NSLocalizedString("两次输入的密码不一致", comment: ""))
            return
        }

        view.endEditing(true)

        let params = ["mobile": account!, "captcha": verifyCode!, "password": pwd!.md5(), "areaCode": currentDistrictCode]
        LoginServices.findPassword(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.show(withStatus: NSLocalizedString("找回密码成功", comment: ""), completionHandle: {
                self.navigationController?.popViewController(animated: true)
            })

        }) { (error) in

        }
    }

    // 获取验证码
    @objc func verifyCodeBtnClick() {
        let account = accountTextField?.text
        if (account?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入手机号", comment: ""))
            return
        }
        view.endEditing(true)

        let params = ["mobile": account ?? "", "areaCode": currentDistrictCode, "language": CommonUtils.currentLanguage()]
        LoginServices.verifyCodeForForget(params: params, showHUD: true, success: { (response) in
            // 保存点击时候的时间
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: AppConstants.startGetVerifyCode)
            UserDefaults.standard.synchronize()

            self.verifyCodeCountdown()
            self.verifyCodeBtn?.isEnabled = false
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.verifyCodeCountdown), userInfo: nil, repeats: true)
            MBProgressHUD.show(withStatus: NSLocalizedString("验证码已发送到您的手机", comment: ""))

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

    // 选择区号
    @objc func districtNumBtnClick() {
        let districtNumVC = DistrictNumViewController()
        districtNumVC.districtArray = districtArray
        districtNumVC.didSelectedDistrictNumBlock = { (districtModel) in
            guard let code = districtModel?.code else {
                self.currentDistrictCode = "86"
                return
            }
            self.currentDistrictCode = code
            self.imageBtn?.setTitle("+\(self.currentDistrictCode)", for: .normal)
        }

        navigationController?.pushViewController(districtNumVC, animated: true)
    }

    @objc func eyeBtnClick(btn: UIButton) {
        if btn.tag == 100 {
            if (showPassword) {
                btn.setImage(UIImage(named: "hide_password"), for: .normal)
                pwdTextField?.isSecureTextEntry = true

            } else {
                btn.setImage(UIImage(named: "show_password"), for: .normal)
                pwdTextField?.isSecureTextEntry = false
            }
            showPassword = !showPassword

        } else {
            if (showRepeatPassword) {
                btn.setImage(UIImage(named: "hide_password"), for: .normal)
                rePwdTextField?.isSecureTextEntry = true

            } else {
                btn.setImage(UIImage(named: "show_password"), for: .normal)
                rePwdTextField?.isSecureTextEntry = false
            }
            showRepeatPassword = !showRepeatPassword

        }
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = GlobalConstants.backgroundColor
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        let backgroundImageView = UIImageView(image: UIImage(named: "login_bg"))
        scrollView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        // LOGO
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(20)
            make.centerX.equalTo(contentView)
            make.width.equalTo(162)
            make.height.equalTo(166)
        }

        // 手机号
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 20))
        let accountImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 15, height: 20), imageName: "mobile_icon")
        accountLeftView.addSubview(accountImageView)

        let accountRightView = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 30))
        let defaultTitle = "+\(currentDistrictCode)"
        imageBtn = ImageButton(title: defaultTitle, titleColor: AppConstants.greyTextColor, textAlignment: .right, font: UIFont(14), image: UIImage(named: "select_country_area"), target: self, selector: #selector(districtNumBtnClick))
        imageBtn?.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        accountRightView.addSubview(imageBtn!)

        accountTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: NSLocalizedString("请输入手机号", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 4, leftView: accountLeftView, rightView: accountRightView)
        contentView.addSubview(accountTextField!)
        accountTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.height.equalTo(44)
        }

        // 验证码
        let verifyCodeLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        let verifyCodeImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20), imageName: "verification_code")
        verifyCodeLeftView.addSubview(verifyCodeImageView)

        verifyCodeTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: NSLocalizedString("请输入验证码", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 4, leftView: verifyCodeLeftView)
        verifyCodeTextField?.keyboardType = .numberPad
        contentView.addSubview(verifyCodeTextField!)
        verifyCodeTextField!.snp.makeConstraints { (make) in
            make.left.height.equalTo(accountTextField!);
            make.top.equalTo(accountTextField!.snp.bottom).offset(20);
        }

        // 获取验证码
        verifyCodeBtn = UIButton(title: NSLocalizedString("获取验证码", comment: ""), titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont(12), backgroundColor: AppConstants.grayColor, borderWidth: 0, borderColor: nil, cornerRadius: 4, target: self, selector: #selector(verifyCodeBtnClick))
        contentView.addSubview(verifyCodeBtn!)
        verifyCodeBtn!.snp.makeConstraints { (make) in
            make.centerY.equalTo(verifyCodeTextField!);
            make.left.equalTo(verifyCodeTextField!.snp.right).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(verifyCodeTextField!)
            make.right.equalTo(accountTextField!)
        }

        // 密码
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        let pwdImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 18, height: 20), imageName: "login_password")
        pwdLeftView.addSubview(pwdImageView)

        let eyeBtn = UIButton(image: UIImage(named: "hide_password"), highlightedImage: UIImage(named: "hide_password"), target: self, selector: #selector(eyeBtnClick))
        eyeBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let pwdRightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        pwdRightView.addSubview(eyeBtn)

        pwdTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: NSLocalizedString("请输入6-16位数字和字符的登录密码", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 4, leftView: pwdLeftView, rightView: pwdRightView)
        pwdTextField?.isSecureTextEntry = true
        contentView.addSubview(pwdTextField!)
        pwdTextField!.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accountTextField!)
            make.top.equalTo(verifyCodeTextField!.snp.bottom).offset(20)
        }

        // 重复密码
        let rePwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        let rePwdImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 18, height: 20), imageName: "login_password")
        rePwdLeftView.addSubview(rePwdImageView)

        let rePwdEyeBtn = UIButton(image: UIImage(named: "hide_password"), highlightedImage: UIImage(named: "hide_password"), target: self, selector: #selector(eyeBtnClick))
        rePwdEyeBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let rePwdRightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        rePwdRightView.addSubview(rePwdEyeBtn)

        rePwdTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: NSLocalizedString("请再次输入登录密码", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 4, leftView: rePwdLeftView, rightView: rePwdRightView)
        rePwdTextField?.isSecureTextEntry = true
        contentView.addSubview(rePwdTextField!)
        rePwdTextField!.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accountTextField!)
            make.top.equalTo(pwdTextField!.snp.bottom).offset(20)
        }

        // 注册
        let confirmBtn = CommonButton(title: NSLocalizedString("确定找回密码", comment: ""), target: self, selector: #selector(confirmBtnClick))
        contentView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(rePwdTextField!.snp.bottom).offset(45)
            make.left.right.height.equalTo(rePwdTextField!)
        }

        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(confirmBtn.snp.bottom).offset(10)
        }
    }
}

