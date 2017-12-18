//
//  FuncTool.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/14.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import Foundation

func dLog(_ message: Any,
               file: String = #file,
             method: String = #function,
               line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
