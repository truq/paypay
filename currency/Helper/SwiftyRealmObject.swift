//
//  SwiftyRealmObject.swift
//  currency
//
//  Created by Noman on 19/12/2020.
//
import Foundation
import RealmSwift
import SwiftyJSON

/**
 SwiftyRealmObject
 - Description : Object derived from Realm object and is the base for all the objects that want be mapped from JSON
 */
open class SwiftyRealmObject: Object {
    
    required convenience public init(json: JSON) {
        self.init()
    }
    
    open class func createList< T>(ofType type: T.Type, fromJson json: JSON) -> List<T> where T: SwiftyRealmObject  {
        let list = List<T>()
        for (_, singleJson):(String, JSON) in json {
            list.append(T(json: singleJson))
        }
        return list
    }
    
}
