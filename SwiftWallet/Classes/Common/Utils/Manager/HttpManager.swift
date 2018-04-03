//
//  HttpManager.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import HandyJSON

class HttpManager: NSObject {

    static let sharedManager: HttpManager = HttpManager()

    fileprivate lazy var sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20 // 设置请求超时时间
        var sessionManager = SessionManager(configuration: config)
        return sessionManager
    }()

    fileprivate func globalHeader() -> HTTPHeaders {

        let token: String? = UserDefaults.standard.value(forKey: AppConstants.token) as? String
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "token": token ?? ""
        ]

        return headers
    }
}

extension HttpManager {

    // MARK: - GET请求
    func get<T: HandyJSON>(url: String, params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: T?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .get, params: params, showHUD: showHUD, success: success, failture: failture)
    }

    // MARK: POST请求
    func post<T: HandyJSON>(url: String, params: [String : Any]?, showHUD: Bool, success: @escaping (_ response: T?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .post, params: params, showHUD: showHUD, success: success, failture: failture)
    }

    // MARK: PUT请求
    func put<T: HandyJSON>(url: String, params: [String : Any]?, showHUD: Bool, success: @escaping (_ response: T?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .put, params: params, showHUD: showHUD, success: success, failture: failture)
    }

    // MARK: 请求基类
    fileprivate func request<T: HandyJSON>(url: String, method: HTTPMethod, params: Parameters?, showHUD: Bool, success: @escaping (_ response: T?) -> (), failture: @escaping (_ error: Error) -> ()) -> () {

        self.showHUD(showHUD: showHUD)
        let requestUrl = ServerUrl.baseUrl() + url

        sessionManager.request(requestUrl, method: method, parameters: params, headers: globalHeader()).responseJSON { (response) in

            switch response.result {

            case .success(let value):
                self.dismissHUD(showHUD: showHUD)

                var responseJson = JSON(value).rawString()
                responseJson = responseJson?.replacingOccurrences(of: "\n", with: "")
                print("\nREQUEST METHOD: \(method.rawValue) \nREQUEST URL: \(requestUrl) \nREQUEST PARAMS: \(String(describing: params)) \nRESPONSE: \(responseJson!)\n\n")

                let responseModel = ResponseModel<T>.deserialize(from: responseJson)
                if responseModel?.code == 401 {
                    // Token失效
                    let errorMsg = responseModel?.msg ?? ""
                    if !errorMsg.isEmpty {
                        MBProgressHUD.show(withStatus: errorMsg)
                    }
                    (UIApplication.shared.delegate as! AppDelegate).logout()

                } else if responseModel?.code != 0 {
                    let errorMsg = responseModel?.msg ?? ""
                    if !errorMsg.isEmpty {
                        MBProgressHUD.show(withStatus: errorMsg)
                    }

                } else {
                    success(responseModel?.content)
                }

            case .failure(let error):
                self.processError(error as NSError)
                failture(error)
            }
        }
    }

    // 处理错误
    func processError(_ error: NSError) {
        dismissHUD(showHUD: true)
        print("HTTP REQUEST ERROR: \(error)")

        let errorCode = error.code
        let errorMessage = error.localizedDescription
        if errorCode == -1001 {
            if errorMessage.contains("请求超时") || errorMessage.contains("The request timed out") {
                MBProgressHUD.show(withStatus: NSLocalizedString("请求超时", comment: ""))
                return;

            } else if errorMessage.contains("not found") { // 404、500
                MBProgressHUD.show(withStatus: NSLocalizedString("服务器出错", comment: ""))
                return;

            } else if errorMessage.contains("422") { // 422
                MBProgressHUD.show(withStatus: NSLocalizedString("请求出错", comment: ""))
                return;

            } else if errorMessage.contains("503") { // 503
                MBProgressHUD.show(withStatus: NSLocalizedString("服务器出错", comment: ""))
                return;
            }

        } else if errorCode == -1004 {
            if errorMessage.contains("未能连接到服务器") ||
               errorMessage.contains("Could not connect to the server") {
                MBProgressHUD.show(withStatus: NSLocalizedString("未能连接到服务器", comment: ""))
                return;
            }

        } else if errorCode == -1005 {
            if errorMessage.contains("网络连接已中断") ||
               errorMessage.contains("The network connection was lost") {
                MBProgressHUD.show(withStatus: NSLocalizedString("网络连接已中断", comment: ""))
                return;
            }

        } else if errorCode == -1009 {
            if errorMessage.contains("似乎已断开与互联网的连接") ||
               errorMessage.contains("The Internet connection appears to be offline") {
                MBProgressHUD.show(withStatus: NSLocalizedString("无网络连接", comment: ""))
                return;
            }
        }
    }

    // MARK: - Private Method
    func showHUD(showHUD: Bool) {
        if showHUD {
            MBProgressHUD.showLoading()
        }
    }

    func dismissHUD(showHUD: Bool) {
        if showHUD {
            MBProgressHUD.dismiss()
        }
    }
}
