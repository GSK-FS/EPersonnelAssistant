//
//  RegisterUserCell.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/8/21.
//

import UIKit
class WelcomeCell : UITableViewCell {
    
    //MVVM Structure
    var userViewModel : UserViewModel! {
        didSet{
            nameTextField.text = userViewModel.name
            
        }
    }
    
    //MVC structure
    var userData : UserModel? {
        didSet{
            nameTextField.text = userData?.name
            
            
        }
    }
    
    
    
    let nameHeadLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameTextField : FormTextField = {
        let textField = FormTextField()
        
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.disableAutoFill()
        //textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor(r: 188, g: 188, b: 188).cgColor
        textField.placeholder = "Enter full Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let registerButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.backgroundColor = UIColor.systemPurple.cgColor
        button.setTitle("Register", for: .normal)
        
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(r: 245, g: 245, b: 245)
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
        
        self.addSubview(nameHeadLabel)
        self.contentView.addSubview(nameTextField)
        self.addSubview(registerButton)
        
        nameHeadLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        nameHeadLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        nameHeadLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        nameHeadLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameHeadLabel.bottomAnchor, constant: 6).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        registerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
}
