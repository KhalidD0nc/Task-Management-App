//
//  Migrator.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 18/07/2023.
//

import Foundation
import RealmSwift

class Migrator {
    
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        var config = Realm.Configuration()
        config.schemaVersion = 1
        config.migrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: UserModel.className()) { oldObject, newObject in
                    
                }
            }
            
        }
        
        
    }
}
