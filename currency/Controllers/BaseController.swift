//
//  BaseController.swift
//  currency
//
//  Created by Noman on 18/12/2020.
//

import UIKit
import SwiftyJSON

class BaseController: UIViewController {
    
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func readJSONFromFile(fileName: String) -> JSON?
      {
          var json: JSON?
          if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
              do {
                  let fileUrl = URL(fileURLWithPath: path)
                  // Getting data from JSON file using the file URL
                  let data = try Data(contentsOf: fileUrl)

                  json = try JSON(data: data)
              } catch {
                  // Handle error here
              }
          }
          return json
      }
    // FETCH CURRENCY LIST FROM API
    func fetchCurrencyListFromNetwork(callback: @escaping  (() -> Void)){
        
        if (AppUtil.isLimitExpired()){
            MainServices.fetchListOfCurrency(params:[ACCESS_KEY:ACCESS_KEY_VALUE]) { (response, error) in
                if let dict = response?["currencies"].dictionary {
                    for (key, value) in dict {
                        let currency = Currency()
                        currency.iso_code = key
                        currency.name = value.string
                        DBManager.shared.addData(object: currency)
                    }
                    callback()
                }
            }
        }
        else{
            callback()
        }
    }
    
}
