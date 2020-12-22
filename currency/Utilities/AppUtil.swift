//
//  AppUtil.swift
//  currency
//
//  Created by Noman on 20/12/2020.
//

import Foundation


import Foundation
import MBProgressHUD


class AppUtil: NSObject {
    
    static func getConvertedValue(selectedCR: Double, rate: Double, userValue: Double) -> Double {
        
        var calculatedValue = DEFAULT_CURRENCY_VALUE
        if (selectedCR < DEFAULT_CURRENCY_VALUE){
            calculatedValue = rate * userValue
        }else{
            calculatedValue = userValue / rate
        }
        return calculatedValue
    }
    
    static func isLimitExpired() -> Bool{
        
        var state : Bool = false
        if (!AppUtil.isFirstRequest()){
            state = true
        }
        
         if let date = UserDefaults.standard.object(forKey: k_LAST_REQUEST_TIME) as? Date {
            if let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute, diff > REQUEST_TIME_LIMIT {
                state = true
            }
        }
        return state
    }
    
    static func setRequestLimitTime(){
        UserDefaults.standard.set(Date(), forKey:k_LAST_REQUEST_TIME)
    }
    
    static func setFirstRequest(){
        UserDefaults.standard.setValue(true, forKey: k_FIRST_REQUEST)
    }
    
    static func isFirstRequest() -> Bool{
       return UserDefaults.standard.bool(forKey: k_FIRST_REQUEST)
    }
    
    
}

extension Double {
    var dollarString:String {
        return String(format: DECIMAL_PLACES, self)
    }
}

extension Dictionary {
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
}
