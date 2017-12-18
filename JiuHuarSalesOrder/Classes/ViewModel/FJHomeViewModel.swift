//
//  FJHomeViewModel.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/13.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class FJHomeViewModel: NetWorkRootViewModel {

    var page: Int = 1
    var newestComments = [Any]()
    
    func fetchHomeData(completion:((Bool,Bool)->Void)?)
    {
        let url = "https://apipreview2.jiuhuar.com/api" + "/v8/index"

        self.httpURLPath(url, method: .get, parameters: nil) { (sucess, responseObject) in
            var reachEnd = false
            if sucess , let data = responseObject {
                
                var tempArry = [Any]()
                if self.page > 1 {
                    tempArry = self.newestComments
                }
                
                for dic in data["newestComments"].arrayValue {
                    if let beerModel = Mapper<BeerModel>().map(JSONObject: dic.object) {
                        tempArry.append(beerModel)
                        if let chineseName = beerModel.chineseName {
                            dLog("--- \(chineseName)")
                        }
                    }
                }
                
                // 默认有更多数据
                reachEnd = true
                self.page += 1
                
                self.newestComments = tempArry
                
            }
            
            if let completion = completion {
                completion(sucess,reachEnd)
            }
        }
    }
    
}
