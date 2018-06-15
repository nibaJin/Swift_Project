//
//  NSObjectExtension.swift
//  DreamBrewCRM
//
//  Created by 孟伟 on 2018/1/4.
//  Copyright © 2018年 Jiuhuar. All rights reserved.
//

import Foundation

extension NSObject {
    func deepCopy() -> NSObject? {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? NSObject
    }
}
