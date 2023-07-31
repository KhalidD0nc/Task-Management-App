//
//  User.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 18/07/2023.
//

import Foundation
import RealmSwift

class UserModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var isFirstTime: Bool = true
    
    override class func primaryKey() -> String? {
        "id"
    }
     
    
}
