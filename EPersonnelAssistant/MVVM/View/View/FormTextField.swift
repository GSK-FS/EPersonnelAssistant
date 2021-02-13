//
//  FormTextField.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/8/21.
//

import UIKit

class FormTextField: UITextField {
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setup()
        
    }
 
    
    func setup() {
                let border = CALayer()
                let width = CGFloat(1.0)
            border.borderColor = UIColor(r: 188, g: 188, b: 188).cgColor
            //border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = 1//width
            //self.layer.addSublayer(border)
            self.layer.masksToBounds = true
//        let fieldIcon = UIImage(named: "lock_24_icon")
//        self.layer.addSublayer(fieldIcon)
                
        paddingLeftSide()
        
        self.addSubview(iconImageView)
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
    
    
    func paddingLeftSide() {
        let leftViewCustom = UIView(frame: CGRect(x:0, y: 0, width: 48, height: self.frame.height))
        
        self.leftViewMode = .always
        self.leftView = leftViewCustom
        //self.backgroundColor = UIColor.white
    }
    
}
