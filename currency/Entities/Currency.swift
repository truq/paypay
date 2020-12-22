//
//  Currency.swift
//  currency
//
//  Created by Noman on 19/12/2020.
//

import Foundation
import SwiftyJSON
import RealmSwift

public class Currency:SwiftyRealmObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let iso_code = "iso_code"
        static let rate = "rate"
    }
    @objc dynamic var name: String?
    @objc dynamic var iso_code: String?
    @objc dynamic var rate: Double = DEFAULT_CURRENCY_VALUE
    
    override public static func primaryKey() -> String? {
        return Currency.SerializationKeys.iso_code
    }
    
    public convenience init(object: Any) {
      self.init(json: JSON(object))
    }
    /// Initiates the instance based on the JSON that was passed.
    /// - parameter json: JSON object from SwiftyJSON.
    public convenience required init(json: JSON) {
      self.init()
        name = json[SerializationKeys.name].string
        iso_code = json[SerializationKeys.iso_code].string
        rate = json[SerializationKeys.rate].double ?? DEFAULT_CURRENCY_VALUE
    }
    
}
