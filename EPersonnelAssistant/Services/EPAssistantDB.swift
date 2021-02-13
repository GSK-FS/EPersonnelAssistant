//
//  FirebaseServices.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/9/21.
//

import Foundation
import Firebase
import UIKit

class MyEPAssistantDB {
    static func getAllUserModelData() -> [UserModel]{
        var arrayData = [UserModel]()
//        arrayData = [UserModel(u_id: <#T##String#>, name: <#T##String#>, email: <#T##String#>, number: <#T##String#>, department: <#T##String#>, password: <#T##String#>, rePassword: <#T##String#>)]
//        
        return arrayData
    }
}


protocol EPAssistantDB {
    func add(usingUserEPA userEPA: EPAssistantDB) -> Bool
    func update(usingUserEPA userEPA: EPAssistantDB) -> Void
    func delete(usingUidEPA uidEPA: String) -> Void
}




func signin(email : String, password : String){

    
    
    
    //return error, success
}
