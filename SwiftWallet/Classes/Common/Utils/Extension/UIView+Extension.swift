//
//  UIView+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // x
    public var left: CGFloat {
        
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    // y
    public var top: CGFloat {
        
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    //
    public var right: CGFloat {
        
        get {
            return self.left + self.width
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    //
    public var bottom: CGFloat {
        
        get {
            return self.top + self.height
        }
        
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    //
    public var centerX : CGFloat {
        
        get {
            return self.center.x
        }
        
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    //
    public var centerY : CGFloat {
        
        get {
            return self.center.y
        }
        
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    //
    public var width: CGFloat {
        
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    //
    public var height: CGFloat {
        
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    //
    public var origin: CGPoint {
        
        get {
            return self.frame.origin
        }
        
        set {
            self.left = newValue.x
            self.top = newValue.y
        }
    }
    
    //
    public var size: CGSize {
        
        get {
            return self.frame.size
        }
        
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }

    // 创建一个UIView(有背景颜色)
    convenience init(backgroundColor: UIColor?) {
        self.init()
        self.backgroundColor = backgroundColor
    }
}
