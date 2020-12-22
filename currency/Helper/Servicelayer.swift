//
//  Servicelayer.swift
//  currency
//
//  Created by Noman on 19/12/2020.
//


import Foundation
import Alamofire
import SwiftyJSON

class Servicelayer: NSObject {
    
    static func requestWithGETWithParam(parameters:[String:Any], apiName : String,
                                     completionHandler:
        @escaping (_ success : Bool, _ response : JSON?, _ error : Error?) -> Void) {
        print(apiName);
        
        //Mark check internet Connectivity
        if !Connectivity.shared.isConnectedToNetwork(){
            DismissRequest()
            return;
        }
        
        Alert.showLoader(message: "")
        AF.request(apiName, parameters: parameters).responseJSON{ (response:AFDataResponse<Any>) in
            
            Alert.hideLoader();
            switch response.result {
            case let .success(value):
                
                let response = JSON(value)
                let dic = response.dictionaryObject
                print(dic?.prettyPrintedJSON ?? "")
                completionHandler(response["success"].boolValue, response,nil)
                
            case let .failure(error):
                print("Request failed with error: \(error)")
                Alert.showToast(message: "Network Connectivity Failed")
            }
            
        }
    }

    static func DismissRequest(){
        Alert.hideLoader()
        Alert.showAlert(title: "No Internet Connection", message: "Make sure your device is connected to internet");
    }

}

