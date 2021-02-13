//
//  ViewController.swift
//  EPersonnelAssistant
//
//  Created by GSK on 1/29/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref : DatabaseReference!
    
    let arrayTextFieldImage = ["email_24_icon", "lock_24_icon"]
    
    let mainBackGroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let nameWelcomeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "Welcome to EPA"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let loginGuideLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Login to Continue"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let emailHeadLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let emailTextField : FormTextField = {
        let textField = FormTextField()
        textField.iconImageView.image = UIImage(named: "email_24_icon")
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        //textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor(r: 188, g: 188, b: 188).cgColor
        textField.leftViewMode = .always
        //textField.leftView = UIImageView(image: UIImage(named: "email_24_icon"))//UIImageView(image: UIImage(named: arrayTextFieldImage[0]))
        textField.placeholder = "Enter email address"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordHeadLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let passwordTextField : FormTextField = {
        let textField = FormTextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        //textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor(r: 188, g: 188, b: 188).cgColor
        textField.leftViewMode = .always
        textField.iconImageView.image = UIImage(named: "lock_24_icon")
        //textField.leftView = UIImageView(image: UIImage(named: "lock_24_icon"))
        textField.placeholder = "Enter EPA password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let forgetPasswordButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setTitleColor(UIColor(r: 156, g: 39, b: 176), for: .normal)
        button.setTitle("Forget Password ?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(loginHandle), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.layer.backgroundColor = UIColor(r: 156, g: 39, b: 176).cgColor
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginWithButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setTitleColor(UIColor(r: 156, g: 39, b: 176), for: .normal)
        button.setTitle("Login with", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let newUserLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "New user"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let registerNowButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(newUserRegisterHandle), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.setTitleColor(UIColor(r: 156, g: 39, b: 176), for: .normal)
        button.setTitle("Register now ?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var daniyal : String!
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginVC = LoginViewController()
        
      
        print(daniyal)
        
            //do something if it's an instance of that class
        self.navigationController?.isNavigationBarHidden = true
        
        
        mainSubViewsSetup()
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @objc func newUserRegisterHandle() {
        print("NewUser pressed...")
        let registerUserController = RegisterViewController()
        navigationController?.pushViewController(registerUserController, animated: true)
        //present(registerUserController, animated: true, completion: nil)
        
    }
    
    @objc func forgetHandle() {
        print("forgetPassword pressed...")
    }
    
    @objc func loginWithHandle() {
        print("forgetPassword pressed...")
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Fields are empty")
            
            return
        }
    }
    
    func userAlreadyLogin() {
        let vc = BottomMenuTabBar()//UserDashBoardViewController()
        navigationController?.popViewController(animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
        //dismiss(animated: true, completion: nil)
    }

    func mainSubViewsSetup() {
        // x, y, width, height
        view.addSubview(mainBackGroundView)
        
        NSLayoutConstraint.activate([mainBackGroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        mainBackGroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        mainBackGroundView.widthAnchor.constraint(equalToConstant: view.frame.width),
        mainBackGroundView.heightAnchor.constraint(equalToConstant: view.frame.height)])
        
        //scroll sub View
        mainBackGroundView.addSubview(mainScrollView)
        
        scrollSubViewsSetup()
    }
    func scrollSubViewsSetup() {
        // x, y, width, height
        mainScrollView.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        mainScrollView.centerYAnchor.constraint(equalTo: mainBackGroundView.centerYAnchor, constant: 0).isActive = true
        mainScrollView.widthAnchor.constraint(equalToConstant: mainBackGroundView.frame.width).isActive = true
        mainScrollView.heightAnchor.constraint(equalToConstant: mainBackGroundView.frame.height).isActive = true
        
        mainBackGroundView.addSubview(nameWelcomeLabel)
        mainBackGroundView.addSubview(loginGuideLabel)
        mainBackGroundView.addSubview(emailHeadLabel)
        mainBackGroundView.addSubview(emailTextField)
        mainBackGroundView.addSubview(passwordHeadLabel)
        mainBackGroundView.addSubview(passwordTextField)
        mainBackGroundView.addSubview(forgetPasswordButton)
        mainBackGroundView.addSubview(loginButton)
        mainBackGroundView.addSubview(loginWithButton)
        mainBackGroundView.addSubview(newUserLabel)
        mainBackGroundView.addSubview(registerNowButton)
        
        componentsViewsSetup()
    }
    
    func componentsViewsSetup() {
        // x, y, width, height
        nameWelcomeLabel.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        nameWelcomeLabel.topAnchor.constraint(equalTo: mainBackGroundView.topAnchor, constant: 70).isActive = true
        nameWelcomeLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameWelcomeLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        loginGuideLabel.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        loginGuideLabel.topAnchor.constraint(equalTo: nameWelcomeLabel.bottomAnchor, constant: 5).isActive = true
        loginGuideLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginGuideLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        emailHeadLabel.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        emailHeadLabel.topAnchor.constraint(equalTo: loginGuideLabel.bottomAnchor, constant: 35).isActive = true
        emailHeadLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        emailHeadLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailHeadLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordHeadLabel.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        passwordHeadLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordHeadLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        passwordHeadLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        passwordTextField.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordHeadLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        forgetPasswordButton.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -25).isActive = true
        forgetPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        forgetPasswordButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        forgetPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        loginButton.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        loginButton.topAnchor.constraint(equalTo: forgetPasswordButton.bottomAnchor, constant: 25).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginWithButton.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        loginWithButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 25).isActive = true
        loginWithButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginWithButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        newUserLabel.centerXAnchor.constraint(equalTo: mainBackGroundView.centerXAnchor, constant: 0).isActive = true
        newUserLabel.topAnchor.constraint(equalTo: loginWithButton.bottomAnchor, constant: 25).isActive = true
        newUserLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        newUserLabel.bottomAnchor.constraint(equalTo: mainBackGroundView.bottomAnchor, constant: -35).isActive = true
        
        registerNowButton.trailingAnchor.constraint(equalTo: newUserLabel.trailingAnchor, constant: 0).isActive = true
        registerNowButton.centerYAnchor.constraint(equalTo: newUserLabel.centerYAnchor, constant: 0).isActive = true
        registerNowButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        registerNowButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    

}

extension LoginViewController {
    @objc func loginHandle() {
        print("login pressed...")
        if emailTextField.text == "" && passwordTextField.text == "" {
            view.showToast(toastMessage: "Please Enter Email and Password,beacuse it is necessary to add For getting logged in.", duration: 1.1)
        }
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            
            print("Form is not valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          //guard let strongSelf = self else { return }
            if error != nil {
                print(error!)
                self?.view.showToast(toastMessage: "Please Enter Valid Email and Password,beacuse it is necessary to add For getting logged in.", duration: 1.5)
                return
            }
          // ...
            print("login success...")
//            UserDefaults.standard.set(true, forKey: "alreadyLoggedIn")
//            UserDefaults.standard.synchronize()
            self?.userAlreadyLogin()
            
        }
        
    }
}
