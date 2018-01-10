//
//  String+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // MD5加密
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return String(format: hash as String)
    }

    /// 校验字符串的长度是否为8-16且包含数字和字符
    func validPasswordFieldFormatter() -> Bool {
        var result = false
        let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        result = predicate.evaluate(with: self)

        return result
    }

    /** 处理HTML字符串，让图片和内容适应屏幕宽度 */
    func processHTMLString() -> String {

        /**
         * " $img[p].style.width = '100%%';\n"--->就是设置图片的宽度的
         * 100%代表正好为屏幕的宽度
         */
        let str = String(format: "<html> <head> <style type=\"text/css\"> body {font-size:13px;} </style> </head> <body> <script type='text/javascript'> window.onload = function(){ var $img = document.getElementsByTagName('img'); for(var p in  $img){ $img[p].style.width = '100%%'; $img[p].style.height ='auto' }} </script>%@</body> </html>", self)

        return str
    }
}
