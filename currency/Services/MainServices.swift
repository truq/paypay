//
//  MainServices.swift
//  currency
//
//  Created by Noman on 19/12/2020.
//

import Foundation
import SwiftyJSON


class MainServices {
    
    static func fetchListOfCurrency(params:[String : Any], callback: @escaping  ((JSON?, Error?) -> Void)){
        Servicelayer.requestWithGETWithParam(parameters: params, apiName: GET_LIST) { (state, response, error) in
            callback(response,error)
        }
    }
    
    static func fetchLiveRate(params:[String : Any], callback: @escaping  ((JSON?, Error?) -> Void)){
        Servicelayer.requestWithGETWithParam(parameters: params, apiName: GET_LIVE) { (state, response, error) in
            callback(response,error)
        }
    }
}
