//
//  HistoryViewController.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/9/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

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
    
    let attendenceHistoryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Attendance History"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weekButton : UIButton = {
        let button = UIButton()
        //button.addTarget(self, action: #selector(loginHandle), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.layer.backgroundColor = UIColor(r: 156, g: 39, b: 176).cgColor
        button.setTitle("Week", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let monthButton : UIButton = {
        let button = UIButton()
        //button.addTarget(self, action: #selector(loginHandle), for: .touchUpInside)
        button.layer.cornerRadius = 36/2
        button.layer.backgroundColor = UIColor.white.cgColor//(r: 156, g: 39, b: 176).cgColor
        button.setTitle("Month", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //date change View
    let dateChangeView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    
    let historyTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        //tableView.rowHeight = 100
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = false
        tableView.layer.masksToBounds = false
        tableView.layer.cornerRadius = 10
        tableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowRadius = 10
        //tableView.layer.shadowPath = CGPath(rect: <#T##CGRect#>, transform: <#T##UnsafePointer<CGAffineTransform>?#>)
        //tableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tableView.layer.shadowColor = UIColor(r: 188, g: 188, b: 188).cgColor
        tableView.backgroundColor = UIColor.white//(r: 245, g: 245, b: 245)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.title = "History"
        mainSubViewsSetup()
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {


            return "Attendence Time"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        
        let textLableV = cell.textLabel
        textLableV?.numberOfLines = 0
        
        textLableV?.text = "Date: 10 Feb, 2021 \n          Time In:     09:00 \n          Time Out:  18:00"
        //cell.accessoryView.
        return cell
    }
    
    
    
    //MARK:- Constrant Setups
    func mainSubViewsSetup() {
        // x, y, width, height
        view.addSubview(mainBackGroundView)
        
        NSLayoutConstraint.activate([mainBackGroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        mainBackGroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        mainBackGroundView.widthAnchor.constraint(equalToConstant: view.frame.width),
        mainBackGroundView.heightAnchor.constraint(equalToConstant: view.frame.height)])
        
        //scroll sub View
        mainBackGroundView.addSubview(attendenceHistoryLabel)
        mainBackGroundView.addSubview(weekButton)
        mainBackGroundView.addSubview(monthButton)
        mainBackGroundView.addSubview(dateChangeView)
        
        
        
        
        historyViewSetup()
    }
    
    func historyViewSetup() {
        mainBackGroundView.addSubview(historyTableView)
        
        historyTableView.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 15).isActive = true
        historyTableView.topAnchor.constraint(equalTo: mainBackGroundView.topAnchor, constant: 70).isActive = true
        historyTableView.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor , constant: -15).isActive = true
        //historyTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        historyTableView.bottomAnchor.constraint(equalTo: mainBackGroundView.bottomAnchor, constant: -55).isActive = true
        
    }

}
