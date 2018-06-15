//
//  DateExtension.swift
//  DreamBrewCRM
//
//  Created by jin fu on 2018/1/2.
//  Copyright © 2018年 Jiuhuar. All rights reserved.
//

import Foundation

extension Date {
    
    // 2018年01月02日
    var stringYYYYMMdd: String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "YYYY年MM月dd日"
        return dateFormat.string(from: self)
    }
    
    // 2018年01月02日
    var stringYYYY_MM_dd: String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormat.string(from: self)
    }
    
    // 2018年01月02日
    var stringYYYYMMddHHmmss: String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "YYYY年MM月dd日 HH:mm:ss"
        return dateFormat.string(from: self)
    }
    
    // withFormat : YYYY_MM_dd mm:hh:ss
    func string(_ withFormat: String) -> String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = withFormat
        return dateFormat.string(from: self)///String From Date 
    }
    
}
