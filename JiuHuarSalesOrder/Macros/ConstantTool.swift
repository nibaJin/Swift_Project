//
//  ConstantTool.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/15.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import Foundation
import UIKit
// screen width
let mainWidth: CGFloat = UIScreen.main.bounds.size.width

// scree height
let fullHeight: CGFloat = UIScreen.main.bounds.size.height

// nav height
let navHeight: CGFloat = {
    if __CGSizeEqualToSize(CGSize.init(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) {
        return 88
    } else {
        return 64
    }
}()

