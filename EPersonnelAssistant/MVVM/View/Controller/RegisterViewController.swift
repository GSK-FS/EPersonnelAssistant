//
//  RegisterViewController.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/1/21.
//

//import UIKit
import Firebase

class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var ref : DatabaseReference!
    
    var arrayData = [UserModel]()
    
    
    var userViewModels = [UserViewModel]()
    let cellId = "cellId"
    
    
    let arrayHeadLabel = ["Name", "Email", "Mobile Number", "Department", "Password", "Re-Password"]
    let arrayTextFieldImage = ["user_24_icon", "email_24_icon", "mobile_24_icon", "department_24_icon", "lock_24_icon", "lock_24_icon"]
    
    let arrayTextField = ["Enter full name", "Enter your email", "Enter mobile Number", "Add department", "Enter Password for EPA", "Re Enter Password"]
    
    
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
    
    let getStartedLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Let's get started"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let registerLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Register"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let registerButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        //button.addTarget(self, action: #selector(btnLoginPressed), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.layer.backgroundColor = UIColor(r: 156, g: 39, b: 176).cgColor
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registerFormTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(WelcomeCell.self, forCellReuseIdentifier: "cellId")
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    var name: String = ""
    var email: String = ""
    var number: String = ""
    var department: String = ""
    var password: String = ""
    var rePassword: String = ""
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerFormTableView.dataSource = self
        registerFormTableView.delegate = self
        mainSubViewsSetup()
        
        // Do any additional setup after loading the view.
        arrayData = MyEPAssistantDB.getAllUserModelData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK:- onKeyboard show Screen Float
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                //registerFormTableView.frame.origin.y -= keyboardSize.height
                tableHight?.isActive = false
                tableHight = registerFormTableView.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 4 + keyboardSize.height)
                tableHight?.isActive = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            tableHight?.isActive = false
            tableHight = registerFormTableView.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 4)
            tableHight?.isActive = true
        }
    }
    
    
    
    //MARK:- Upload Firebase
    @objc func handleRegister(){
        print("Register user data...")
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {[self](userData, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = userData?.user.uid else {return}
            ref = Database.database().reference()
            let usersRef = ref.child("users").child(uid)
            
            let values = ["Name": name, "Email": email, "Number": number, "Department": department, "Password": password, "RePassword": rePassword]
            
            var model: UserModel!
            model.department = department
            model.name = name
            model.email = email
            model.number = number
            model.password = password
                
//            ref.setValue(model)
            ref.setValue(model, withCompletionBlock: { err, ref in
                if let error = err {
                    print("userInfoDictionary was not saved: \(error.localizedDescription)")
                } else {
                    print("userInfoDictionary saved successfully!")
                }
            })
            
//            usersRef.updateChildValues(values as [AnyHashable : Any], withCompletionBlock: {[self](err, ref) in
//                if err != nil {
//                    print(err!)
//                    return
//                }
//                print("saved user Successfully in cloud")
//                navigationController?.popViewController(animated: true)
//                //dismiss(animated: true, completion: nil)//dismiss Register controller
//
//            })
            
        })
        
    }

    
    //MARK: Login Action
    
    @objc func btnLoginPressed(_ sender: UIButton) {
//        if name == ""
//        {
//            //Call UIView extension method
//            self.view.showToast(toastMessage: "Please Enter Username,beacuse it is necessary to add For getting logged in.", duration: 1.1)
//        }
//        else if name == ""
//        {
//            self.view.showToast(toastMessage: "Please Enter Password.", duration: 1.1)
//        }
//        else
//        {
//            //Do login
//        }
        
    }
    
    
    func alreadyUserHandle() {
        print("alreadyUser ...")
    }
    
    // MARK: - Navigation
    func nav() {
        print("nav")
    }
    
    //tap handler to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //MARK:- Table func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayHeadLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! WelcomeCell
        //if let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! WelcomeCell {
            
            //let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
            
            //            let userViewModel = userViewModels[indexPath.row]
            //            cell.userViewModel = userViewModel
            
            //cell.nameTextField.disableAutoFill()
            //cell.nameTextField.tag = indexPath.row
            cell.nameTextField.delegate = self
            //cell.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cell.nameTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
            
            cell.nameHeadLabel.text = arrayHeadLabel[indexPath.row]
            cell.nameTextField.placeholder = arrayTextField[indexPath.row]
            cell.nameTextField.leftViewMode = .always
            cell.nameTextField.iconImageView.image = UIImage(named: arrayTextFieldImage[indexPath.row])
            //cell.nameTextField.leftView = UIImageView(image: UIImage(named: arrayTextFieldImage[indexPath.row]))
            
            //Name
//                        if indexPath.row == 0 {
//                            cell.nameTextField.keyboardType = .default
//                            cell.nameTextField.autocapitalizationType = .none
//                        }
//
//                        //email Keyboard style
//                        else if indexPath.row == 1 {
//                            cell.nameTextField.keyboardType = .emailAddress
//                            cell.nameTextField.autocapitalizationType = .none
//                        }
//                        //number keyboard style
//                        else if indexPath.row == 2 {
//                            cell.nameTextField.keyboardType = .phonePad
//                            cell.nameTextField.autocapitalizationType = .none
//                        }
//                        //Department
//                        else if indexPath.row == 3 {
//                            cell.nameTextField.keyboardType = .default
//                            cell.nameTextField.autocapitalizationType = .none
//                        }
//
//                        else if indexPath.row >= 4 {
//                            cell.nameTextField.isSecureTextEntry = true
//                            cell.nameTextField.autocapitalizationType = .none
//                        }
        
        
        
            cell.selectionStyle = .none
            return cell
        //}
        //return UITableViewCell() //Safe Wrapper
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell.SelectionStyle = UITableViewCell.SelectionStyle.none
    }
    enum TextFieldData : Int {
        
        case nameTextField
        case emailTextField
        case phoneTextField
        case departmentTextField
        case passwordTextField
        case repeatPasswordTextField
        
    }
    @objc func valueChanged(_ textField: UITextField){
            
            switch textField.tag {
            case TextFieldData.nameTextField.rawValue:
                name = textField.text!
                
            case TextFieldData.emailTextField.rawValue:
                email = textField.text!
                
            case TextFieldData.phoneTextField.rawValue:
                number = textField.text!
                
            case TextFieldData.departmentTextField.rawValue:
                department = textField.text!
                
            case TextFieldData.passwordTextField.rawValue:
                password = textField.text!
            textField.isSecureTextEntry = true
                
            case TextFieldData.repeatPasswordTextField.rawValue:
                rePassword = textField.text!
            textField.isSecureTextEntry = true
            default:
                break
            }
        }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//
//        //        if let name = snap.value as? String{
//        //                 self.nameLabel.text = name
//        //          }
//
//        if textField.tag == 0 {
//            name = textField.text ?? ""
//        } else if textField.tag == 1 {
//            email = textField.text ?? ""
//
//        } else if textField.tag == 2 {
//            number = textField.text ?? ""
//
//        } else if textField.tag == 3 {
//            department = textField.text ?? ""
//        } else if textField.tag == 4 {
//            password = textField.text ?? ""
//        } else if textField.tag == 5 {
//            rePassword = textField.text ?? ""
//        }
//    }
    
    
    
    
    
    
    func mainSubViewsSetup() {
        // x, y, width, height
        view.addSubview(mainBackGroundView)
        
        mainBackGroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mainBackGroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        mainBackGroundView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        mainBackGroundView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        
        mainBackGroundView.addSubview(getStartedLabel)
        mainBackGroundView.addSubview(registerLabel)
        
        getStartedLabel.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 35).isActive = true
        getStartedLabel.topAnchor.constraint(equalTo: mainBackGroundView.topAnchor, constant: 70).isActive = true
        getStartedLabel.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -35).isActive = true
        //getStartedLabel.bottomAnchor.constraint(equalTo:mainBackGroundView.bottomAnchor,constant: -100).isActive = true
        
        registerLabel.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 35).isActive = true
        registerLabel.topAnchor.constraint(equalTo: getStartedLabel.bottomAnchor, constant: 6).isActive = true
        registerLabel.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -35).isActive = true
        registerLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        //scroll sub View
        mainBackGroundView.addSubview(registerFormTableView)
        tableViewSetup()
    }
    
    var tableHight : NSLayoutConstraint?
    
    
    func tableViewSetup() {
        // x, y, width, height
        
        registerFormTableView.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 0).isActive = true
        tableHight = registerFormTableView.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 4)
        tableHight?.isActive = true
        //registerFormTableView.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 4).isActive = true
        registerFormTableView.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: 0).isActive = true
        registerFormTableView.bottomAnchor.constraint(equalTo:mainBackGroundView.bottomAnchor,constant: -100).isActive = true
        
        //Button sub View
        mainBackGroundView.addSubview(registerButton)
        
        registerButton.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 25).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: mainBackGroundView.bottomAnchor, constant: -25).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -25).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    
}



extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
            autocorrectionType = UITextAutocorrectionType.no
        } else {
            textContentType = .init(rawValue: "")
            autocorrectionType = UITextAutocorrectionType.no
        }
    }
}
