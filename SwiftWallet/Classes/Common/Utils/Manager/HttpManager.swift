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

class HttpManager: NSObject {

    static let sharedManager: HttpManager = HttpManager()

    func globalHeader() -> HTTPHeaders {

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
    func get(url: String, params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .get, params: params, showHUD: showHUD, success: success, failture: failture)
    }
    
    // MARK: POST请求
    func post(url: String, params: [String : Any]?, showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .post, params: params, showHUD: showHUD, success: success, failture: failture)
    }

    // MARK: PUT请求
    func put(url: String, params: [String : Any]?, showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .put, params: params, showHUD: showHUD, success: success, failture: failture)
    }

    // MARK: 请求基类
    fileprivate func request(url: String, method: HTTPMethod, params: Parameters?, showHUD: Bool, success : @escaping (_ response : BaseResponseModel?) -> (), failture : @escaping (_ error : Error) -> ()) -> () {

        self.showHUD(showHUD: showHUD)
        let requestUrl = ServerUrl.baseUrl() + url
        Alamofire.request(requestUrl, method: method, parameters: params, headers: globalHeader()).responseJSON { (response) in

            switch response.result {

            case .success(let value):
                self.dismissHUD(showHUD: showHUD)

                let responseJson = JSON(value).rawString()
                print("REQUEST URL: \(requestUrl) \nREQUEST PARAMS: \(String(describing: params)) \nREQUEST METHOD: \(method) \nRESPONSE: \(responseJson!)\n\n")

                let responseModel = self.processResponse(responseJSON: responseJson)
                if responseModel != nil {
                    success(responseModel)
                }

            case .failure(let error):
                self.dismissHUD(showHUD: showHUD)
                print("HTTP REQUEST ERROR: \(error)")
                failture(error)
            }
        }
    }

    func processResponse(responseJSON: Any?) -> BaseResponseModel? {
        guard let response = responseJSON else {
            return nil
        }

        let responseModel = BaseResponseModel.mj_object(withKeyValues: response)

        if responseModel?.statusCode == 401 {
            // Token失效
            let errorMsg = responseModel?.errorMessage ?? ""
            if !errorMsg.isEmpty {
                MBProgressHUD.show(withStatus: errorMsg)
            }

            (UIApplication.shared.delegate as! AppDelegate).logout()
            return nil

        } else if responseModel?.statusCode != 0 {
            let errorMsg = responseModel?.errorMessage ?? ""
            if !errorMsg.isEmpty {
                MBProgressHUD.show(withStatus: errorMsg)
            }
            return nil
        }

        return responseModel!
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
