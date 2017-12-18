//
//  NetWorkRootViewModel.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/12.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class NetWorkRootViewModel {
    
    lazy var sessionManager: SessionManager = {
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: ServerTrustPolicy.certificates(),
            validateCertificateChain: true,
            validateHost: true
        )
        let serverTrustPolicies = ["apipreview2.jiuhuar.com" : serverTrustPolicy]
        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)

        let manager: SessionManager = SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: serverTrustPolicyManager
        )
        
        return manager
    }()
    
    func httpURLPath(_ url:String, method:HTTPMethod = .get, parameters:Parameters? = nil, completionHandle:((Bool, JSON?) -> ())? = nil) {
        let headers: HTTPHeaders = [:]
        let dataRequest = sessionManager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)

        dataRequest.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                dLog("JSON: \(json)")
                
                var state = false
                var data: JSON? = nil
                let code = json["code"].stringValue
                switch code{
                case "0":
                    state = true
                    data = json["data"]
                default:
                    data = json["msg"]
                }
                
                if let completion = completionHandle {
                    completion(state,data)
                }
            case .failure(let error):
                dLog(error)
                if let completion = completionHandle {
                    completion(false,JSON(error))
                }
            }
        }
    }
}

