//
//  Users.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/9/21.
//

import Foundation

struct UserModel: Decodable {
    var u_id : String
    var name : String
    var email : String
    var number : String
    var department : String
    var password : String
    var rePassword : String
    
    enum CoadingKeys: String, CodingKey {
        case u_id
        case name
        case email
        case number
        case department
        case password
        case rePassword
    }
}


struct Attendance: Decodable {
    let name : String
    let inTime : String
    let outTime : String
    let date : String
//    let firstHalf : Bool
//    let secondHalf : Bool
//    let late : Bool
}
