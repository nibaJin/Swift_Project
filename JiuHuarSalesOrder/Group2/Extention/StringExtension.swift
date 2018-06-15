//
//  StringExtension.swift
//  DreamBrewCRM
//
//  Created by jin fu on 2017/12/26.
//  Copyright © 2017年 Jiuhuar. All rights reserved.
//

import Foundation

extension String {
    func isSpacesEmpty() -> Bool {
        let str = trimmingCharacters(in: .whitespaces)
        return str.isEmpty
    }
    
    func isTel() -> Bool {
        let regex = "^（(13)|(14)|(15)|(16)|(17)|(18)|(19))\\d{9}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    func getSize(font: UIFont, maxSize: CGSize) -> CGSize {
        var resultSize = CGSize.zero
        
        if self.count <= 0 {
            return resultSize
        }
        
        resultSize = (self as NSString).boundingRect(with: maxSize, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [.font : font], context: nil).size;
        return resultSize
    }
    
    func getHeight(font: UIFont, maxSize: CGSize) -> CGFloat {
        return getSize(font: font, maxSize: maxSize).height
    }
}

func StringIsEmpty(_ str: String?) -> Bool {
    guard let str = str, !(str.isSpacesEmpty()) else {
        return true
    }
    return false
}
