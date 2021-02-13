//
//  FirebaseRealTimeDB.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/10/21.
//

import Foundation
import Firebase

class FirebaseRealTimeDB {
    private let firebaseDB = Database.database()
    static let shared : FirebaseRealTimeDB = FirebaseRealTimeDB()
    private let usersCollection = "users"
    
    private init(){}
    //func <#code#>(){}
}

//extension FirebaseRealTimeDB : EPAssistantDB {
////    func add(usingUserEPA userEPA: EPAssistantDB) -> Bool {
////        //collection(usersCollection).addDocument(EPAssistantDB)
////        //return false
////    }
////
////    func update(usingUserEPA userEPA: EPAssistantDB) {
////        //eddit
////    }
////
////    func delete(usingUidEPA uidEPA: String) {
////        <#code#>
////    }
//    
//    
//}
