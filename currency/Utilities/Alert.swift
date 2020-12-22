//
//  Alert.swift
//  currency
//
//  Created by Noman on 19/12/2020.
//
import Foundation
import MBProgressHUD


class Alert: NSObject {
    
   static var loadingAlert : MBProgressHUD!
    
    static func showLoader(message : String){
        
        loadingAlert = MBProgressHUD.showAdded(to:SceneDelegate.getInstance().window!, animated: true)
        loadingAlert.label.text = message
        
        
    }
    static func hideLoader(){
        
        MBProgressHUD.hide(for: SceneDelegate.getInstance().window!, animated: true)
        
    }
    
    static func showAlert(title : String,message : String){
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
            // do something after completation
        }
        alert.addAction(alertAction)
        SceneDelegate.getInstance().window?.rootViewController!.present(alert, animated: true, completion: nil)
            
    }
    static func showToast(message:String){
        
        loadingAlert = MBProgressHUD.showAdded(to: SceneDelegate.getInstance().window!, animated: true)
        loadingAlert.label.text = message
        loadingAlert.label.font = UIFont(name:"Arial", size: 13)!
        loadingAlert.label.numberOfLines = 6
        loadingAlert.mode = MBProgressHUDMode.text
        loadingAlert.margin = 15
        loadingAlert.offset.y = 200
        loadingAlert.removeFromSuperViewOnHide = true
        loadingAlert.hide(animated:true, afterDelay: 1.5)
        
    }
    
    static func showAlert(title : String,message : String, OkActionHandler:@escaping (_ message:Any?)->Void){
        
        let alert = UIAlertController(title: title , message: message  , preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: title , style: UIAlertAction.Style.default) { (action) -> Void in
            // do something after completation
            OkActionHandler(NSLocalizedString("pressed ok", comment: ""))
        }
        alert.addAction(alertAction)
        SceneDelegate.getInstance().window?.rootViewController!.present(alert, animated: true, completion: nil)
        
    }
}
