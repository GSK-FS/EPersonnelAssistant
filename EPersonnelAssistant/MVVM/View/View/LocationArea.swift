//
//  LocationArea.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/8/21.
//

import Foundation

//Office 33.644538, 73.022385 (y, x)
func mapIn() {
    let officeLatitude = 33.644538
    let officeLongitude = 73.022385
    
    let areaRange = 0.000500
    let officeLatitude_A = officeLatitude - (areaRange/2)
    let officeLongitude_B = officeLongitude - (areaRange/2)
    
    let officeLatitudeA = officeLatitude + (areaRange/2)
    let officeLongitudeB = officeLongitude + (areaRange/2)
    
    
    let userLatitude = 33.644400
    let userLongitude = 73.022300
    
    if userLatitude >= officeLatitude_A && userLatitude <= officeLatitudeA{
        print("user is in office")
        if userLongitude >= officeLongitude_B && userLongitude <= officeLongitudeB{
            print("and user Arrived in office")
        }else {
            print("and user is not comming")
        }
        
    } else {
        print("user is Absent")
    }
}


