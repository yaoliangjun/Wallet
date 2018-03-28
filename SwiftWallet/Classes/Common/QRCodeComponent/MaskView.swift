//
//  MaskView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/2/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class MaskView: UIView {

    let margin: CGFloat = 50
    let scannerWidth: CGFloat = 300
    let scannerHeight: CGFloat = 300
    var scanLineLayer: CALayer? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.scanLineLayer = CALayer(layer: layer)
        self.scanLineLayer?.contents = UIImage(named: "code_line")?.cgImage
        self.layer.addSublayer(self.scanLineLayer!)
        self.startAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let width: CGFloat = rect.size.width
        let height: CGFloat = rect.size.height

        // 背景蒙版
        let contextRef = UIGraphicsGetCurrentContext()
        contextRef!.saveGState()
        contextRef?.setFillColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        contextRef?.setLineWidth(3)
        let maskWidth = (width - scannerWidth) / 2
        let maskHeight = (height - scannerHeight) / 2

        let topRect = CGRect(x: 0, y: 0, width: width, height: maskHeight - margin)
        let leftRect = CGRect(x: 0, y: maskHeight - margin, width: maskWidth, height: scannerHeight)
        let rightRect = CGRect(x: width - maskWidth, y: maskHeight - margin, width: maskWidth, height: scannerHeight)
        let bottomRect = CGRect(x: 0, y: height - maskHeight - margin, width: width, height: maskHeight)

        let topBezierPath = UIBezierPath(rect: topRect)
        topBezierPath.usesEvenOddFillRule = true
        topBezierPath.fill()

        let leftBezierPath = UIBezierPath(rect: leftRect)
        leftBezierPath.usesEvenOddFillRule = true
        leftBezierPath.fill()

        let rightBezierPath = UIBezierPath(rect: rightRect)
        rightBezierPath.usesEvenOddFillRule = true
        rightBezierPath.fill()

        let bottomBezierPath = UIBezierPath(rect: bottomRect)
        bottomBezierPath.usesEvenOddFillRule = true
        bottomBezierPath.fill()

        contextRef?.setLineWidth(2)

        // 框框
        let scannerBoxImage = UIImage(named: "code_box")
        let scannerRect = CGRect(x: maskWidth, y: maskHeight - margin, width: scannerWidth, height: scannerHeight)
        scannerBoxImage?.draw(in: scannerRect)

        contextRef?.restoreGState()
        self.layer.contentsGravity = kCAGravityCenter
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
        self.scanLineLayer?.frame = CGRect(x: (self.frame.size.width - scannerWidth) / 2, y: (self.frame.size.height - scannerHeight) / 2 - margin, width: scannerWidth, height: 2)
    }

    func startAnimation() {
        let basic = CABasicAnimation(keyPath: "transform.translation.y")
        basic.fromValue = (0)
        basic.toValue = (self.scannerHeight)
        basic.duration = 2
        basic.repeatCount = Float(NSIntegerMax)
        self.scanLineLayer?.add(basic, forKey: "translationY")
    }

    func stopAnimation() {
        self.scanLineLayer?.removeAnimation(forKey: "translationY")
    }
}
