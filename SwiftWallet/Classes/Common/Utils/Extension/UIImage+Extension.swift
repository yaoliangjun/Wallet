//
//  UIImage+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    /// 使用颜色创建一张图片
    class func createImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }

    class func createQRCodeImage(_ stirng: String, _ size: CGSize) -> UIImage {
        let stringData:Data = stirng.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let qrFileter = CIFilter(name: "CIQRCodeGenerator")
        qrFileter?.setValue(stringData, forKey: "inputMessage")
        qrFileter?.setValue("M", forKey: "inputCorrectionLevel")

        let qrImage = qrFileter?.outputImage
        //放大并绘制二维码（上面生成的二维码很小需要放大）
        let cgImage = CIContext(options: nil).createCGImage(qrImage!, from: (qrImage?.extent)!)

        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = .none

        //反转一下图片，不然生产的QRCode就是上下颠倒的
        context!.scaleBy(x: 1.0, y: -1.0);

        context?.draw(cgImage!, in: context!.boundingBoxOfClipPath)

        let condeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return condeImage
    }
}



