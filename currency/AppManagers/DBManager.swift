//
//  DBManager.swift
//  currency
//
//  Created by Noman on 19/12/2020.
//

import Foundation
import RealmSwift


private let instance = DBManager()


class DBManager{
    class var shared: DBManager{
        return instance
    }
    
    var realm : Realm{
        let config = Realm.Configuration(
            
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
                
        })
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        
        return try! Realm()
    }
    
    func addData(object: Object)   {

        try! realm.write {
            realm.add(object, update: .all)
            print("Added new object")
        }

    }

    func deleteAllFromDatabase()  {
        try! realm.write {
            realm.deleteAll()
        }
    }

    func deleteFromDb(object: Object)   {
        try! realm.write {
            realm.delete(object)
        }
    }
}


extension Results {
    
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
}

