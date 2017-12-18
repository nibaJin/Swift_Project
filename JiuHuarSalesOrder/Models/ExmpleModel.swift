//
//  ExmpleModel.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/14.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import Foundation
import ObjectMapper

class BeerModel:Mappable  {
    var oid: String?
    var mainPic: String?
    var fullName: String?
    var chineseName:String?
    var englishName:String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        if let fullStr = map.JSON["fullName"],
            fullStr is String{
            let str: String = fullStr as! String
            let arr = str.components(separatedBy: "|-|")
            chineseName = arr.first
            englishName = arr.last
        }
    }
    
    func mapping(map: Map){
        oid         <- map["oid"]
        mainPic     <- map["mainPic"]
        fullName    <- map["fullName"]
    }
}
