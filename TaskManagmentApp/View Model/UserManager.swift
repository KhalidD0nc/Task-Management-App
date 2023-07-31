//
//  UserManager.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 18/07/2023.
//

import Foundation
import RealmSwift

class UserManager: ObservableObject {
    @Published var currentUser: UserModel?
    let realm = try! Realm()
     
    init() {
        fetchUser()
    }
    
    func saveUser(his name: String) {
        do {
            let newUser = UserModel()
            newUser.name = name
            try realm.write{
                realm.add(newUser)
            }
        } catch  {
            print("DEBUG: error while save user \(error.localizedDescription)")
        }
    }
    func fetchUser() {
        currentUser = realm.objects(UserModel.self).first
    }
    
    func toogleUserStatus() {
        guard let user = currentUser else {return}
        do {
            try realm.write{
                user.isFirstTime.toggle()
            }
        } catch  {
            print("DEBUG: error while toogle User Status \(error.localizedDescription)")
        }
    }
    
    
}
