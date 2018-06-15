//
//  UIViewExtension.swift
//  DreamBrewCRM
//
//  Created by 孟伟 on 2017/12/20.
//  Copyright © 2017年 Jiuhuar. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    
    var top : CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            var fm : CGRect = frame
            fm.origin.y = top
            frame = fm
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set {
            var frame : CGRect = self.frame
            frame.origin.y = bottom - frame.size.height
            self.frame = frame
        }
    }
    
    var left : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame : CGRect = self.frame
            frame.origin.x = left
            self.frame = frame
        }
    }
    
    var right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        
        set {
            var frame : CGRect = self.frame
            frame.origin.x = right - frame.size.width
            self.frame = frame
        }
    }
    
    var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame : CGRect = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame : CGRect = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    var centerX : CGFloat {
        get {
            return self.center.x
        }
        
        set {
            var ct : CGPoint = self.center
            ct.x = centerX
            self.center = ct
        }
    }
    
    var centerY : CGFloat {
        get {
            return self.center.y
        }
        
        set {
            var ct : CGPoint = self.center
            ct.y = centerY
            self.center = ct
        }
    }
    
    var origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame : CGRect = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
        
    var size : CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame : CGRect = self.frame
            frame.size = size
            self.frame = frame
        }
    }
    
    func removeAllSubviews() {
        while self.subviews.count > 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    func viewController() -> UIViewController? {
        var view : UIView? = self
        while view != nil {
            if let nextResponder = view?.next, nextResponder.isKind(of: UIViewController.self) {
                return nextResponder as? UIViewController
            }
            view = view?.superview
        }
        return nil
    }
    
    func showHUD(message:String? = nil) {
        ShowHUD(superView: self)
    }
    
    func showMessage(_ message:String) {
        ShowHUD(superView: self, info:message)
    }
    
    func showErrorMessage(_ message:String) {
        ShowHUD(superView: self, mode:MBProgressHUDMode.text, info:message, autoHiden:true)
    }
    
    func hideHUD() {
        HideHUD(superView: self)
    }
}
