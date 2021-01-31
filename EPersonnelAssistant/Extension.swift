//
//  Extension.swift
//  EPersonnelAssistant
//
//  Created by GSK on 1/29/21.
//

import UIKit

//MARK:- UICOLOR r.g.b
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
//MARK:- UICOLOR r.g.b.a
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a/1)
    }
}
