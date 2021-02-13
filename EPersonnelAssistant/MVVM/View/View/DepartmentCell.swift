//
//  DepartmentCell.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/8/21.
//

import UIKit
class DepartmentCell : UITableViewCell {
    
    //MVVM Structure
    
    
    
    let memberImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user_24_icon")
        imageView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let mobileIconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        imageView.layer.cornerRadius = 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(r: 59, g: 54, b: 82).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let memberNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = UIColor(r: 59, g: 54, b: 82)
        label.text = "Member Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberMobileNumberLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = UIColor(r: 141, g: 141, b: 141)
        label.text = "03001234567"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let optionDotsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white//(r: 245, g: 245, b: 245)
        cellSetup()
        self.contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func didMoveToSuperview() {
    //            selectionStyle = .none
    //        }
    
    func cellSetup(){
        
        self.addSubview(memberImageView)
        self.addSubview(memberNameLabel)
        self.addSubview(mobileIconImageView)
        self.addSubview(memberMobileNumberLabel)
        self.addSubview(optionDotsButton)
        
        memberImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        memberImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        memberImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        memberImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        memberNameLabel.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 10).isActive = true
        memberNameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -1).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        memberNameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        mobileIconImageView.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 10).isActive = true
        mobileIconImageView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 1).isActive = true
        mobileIconImageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
        mobileIconImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        memberMobileNumberLabel.leadingAnchor.constraint(equalTo: mobileIconImageView.trailingAnchor, constant: 5).isActive = true
        memberMobileNumberLabel.bottomAnchor.constraint(equalTo: mobileIconImageView.bottomAnchor, constant: 0).isActive = true
        memberMobileNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        //memberMobileNumberLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        optionDotsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        optionDotsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        optionDotsButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
        optionDotsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    
}


