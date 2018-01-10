//
//  LoginViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/10.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  登录页面

import UIKit

//#pragma mark - Private Method
//- (void)loginBtnClick
//{
//    NSString *account = _accountTextField.text
//    NSString *password = _pwdTextField.text
//
//    if ([NSString isEmpty:account]) {
//        [MBProgressHUD showWithStatus:NSLocalizedString(@"请输入登录账号Hint", nil)]
//        return
//    }
//
//    if ([NSString isEmpty:password]) {
//        [MBProgressHUD showWithStatus:NSLocalizedString(@"请输入登录密码Hint", nil)]
//        return
//    }
//
//    [self.view endEditing:YES]
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary]
//    params[@"mobile"] = account
//    params[@"password"] = [password md5String]
//    params[@"language"] = [[NSString currentLanguage] containsString:@"en"] ? @"en" : @"zh"
//
//    [LoginServices loginWithParams:params showHUD:YES success:^(HttpResponseModel *responseModel) {
//
//        [MBProgressHUD dismiss]
//        LoginResponseModel *loginResponseModel = [LoginResponseModel mj_objectWithKeyValues:responseModel.content]
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]
//        [defaults setObject:loginResponseModel.token forKey:kToken]
//        [defaults setObject:account forKey:kLoginAccount]
//        [defaults synchronize]
//
//        // 缓存数据
//        [loginResponseModel saveDictModel:responseModel.content]
//
//        // 标识不需要重新登录通知
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kNotificationReLogin]
//        [[AppDelegate sharedDelegate] showMainPage]
//
//        } failure:^(NSError *error) {
//        [MBProgressHUD dismiss]
//        }]
//    }
//
//    // 忘记密码
//    - (void)forgetPasswordBtnClick
//        {
//            ForgetPasswordViewController *forgetPasswordVC = [[ForgetPasswordViewController alloc] init]
//            [self.navigationController pushViewController:forgetPasswordVC animated:YES]
//        }
//
//        // 注册
//        - (void)registerBtnClick
//            {
//                RegisterViewController *registerVC = [[RegisterViewController alloc] init]
//                [self.navigationController pushViewController:registerVC animated:YES]
//            }
//
//            - (void)eyeBtnClick:(UIButton *)btn
//{
//    if (_showPassword) {
//        [btn setImage:[UIImage imageNamed:@"hide_password"] forState:UIControlStateNormal]
//        _pwdTextField.secureTextEntry = YES
//    } else {
//        [btn setImage:[UIImage imageNamed:@"show_password"] forState:UIControlStateNormal]
//        _pwdTextField.secureTextEntry = NO
//    }
//
//    _showPassword = !_showPassword
//}



class LoginViewController: BaseViewController {

    fileprivate var accountTextField: UITextField?
    fileprivate var pwdTextField: UITextField?
    fileprivate var showPassword = false

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        let account = UserDefaults.standard.object(forKey: AppConstants.account) as? String
        if account != nil {
            accountTextField?.text = account
        }
    }

    // MARK: - Private Method
    @objc func loginBtnClick() {

    }

    @objc func registerBtnClick() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

    @objc func forgetPasswordBtnClick() {
        navigationController?.pushViewController(ForgetPasswordViewController(), animated: true)
    }

    @objc func eyeBtnClick(btn: UIButton) {
        if (showPassword) {
            btn.setImage(UIImage(named: "hide_password"), for: .normal)
            pwdTextField?.isSecureTextEntry = true

        } else {
            btn.setImage(UIImage(named: "show_password"), for: .normal)
            pwdTextField?.isSecureTextEntry = false
        }
        showPassword = !showPassword
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
            make.top.equalTo(contentView).offset(70)
            make.centerX.equalTo(contentView)
            make.width.equalTo(162)
            make.height.equalTo(166)
        }

        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(70)
            make.centerX.equalTo(contentView)
            make.width.equalTo(162)
            make.height.equalTo(166)
        }

        // 账户
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        let accountImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20), imageName: "login_account")
        accountLeftView.addSubview(accountImageView)

        accountTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: NSLocalizedString("请输入登录账号", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 4, leftView: accountLeftView, leftViewMode: .always)
        accountTextField?.keyboardType = .numberPad
        contentView.addSubview(accountTextField!)
        accountTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.height.equalTo(44)
        }

        // 密码
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        let pwdImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20), imageName: "login_account")
        pwdLeftView.addSubview(pwdImageView)

        let eyeBtn = UIButton(image: UIImage(named: "hide_password"), highlightedImage: UIImage(named: "hide_password"), target: self, selector: #selector(eyeBtnClick))
        eyeBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let pwdRightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        pwdRightView.addSubview(eyeBtn)

        pwdTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: NSLocalizedString("请输入登录密码", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14), backgroundColor: UIColor.white, borderWidth: 0, borderColor: nil, cornerRadius: 4, leftView: pwdLeftView, rightView: pwdRightView)
        pwdTextField?.keyboardType = .numberPad
        pwdTextField?.isSecureTextEntry = true
        contentView.addSubview(pwdTextField!)
        pwdTextField!.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accountTextField!)
            make.top.equalTo(accountTextField!.snp.bottom).offset(20)
        }

        // 忘记密码
        let forgetPwdBtn = UIButton(title: "忘记密码", titleColor: UIColor.white, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont(11), target: self, selector: #selector(forgetPasswordBtnClick))
        contentView.addSubview(forgetPwdBtn)
        forgetPwdBtn.snp.makeConstraints { (make) in
            make.right.equalTo(pwdTextField!)
            make.top.equalTo(pwdTextField!.snp.bottom).offset(5)
            make.height.equalTo(30)
        }

        // 登录按钮
        let loginBtn = CommonButton(title: "登录", target: self, selector: #selector(loginBtnClick))
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pwdTextField!.snp.bottom).offset(75)
            make.left.right.height.equalTo(pwdTextField!)
        }

        // 注册
        let registerBtn = UIButton(title: "立即注册", titleColor: UIColor.white, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont(13), target: self, selector: #selector(registerBtnClick))
        contentView.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(40)
            make.height.equalTo(30)
            make.centerX.equalTo(contentView)
        }

        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(registerBtn.snp.bottom).offset(20)
        }
    }
}
