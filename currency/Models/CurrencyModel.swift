//
//  CurrencyModel.swift
//  currency
//
//  Created by Noman on 21/12/2020.
//

import Foundation


class CurrencyModel {
    
    static func getCurrenciesfromDB() -> [Currency] {
         return DBManager.shared.realm.objects(Currency.self).toArray().sorted(by: { $0.name! < $1.name! })
    }
    
}
