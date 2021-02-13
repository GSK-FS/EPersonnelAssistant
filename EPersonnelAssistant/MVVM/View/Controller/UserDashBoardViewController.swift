//
//  UserDashBoardViewController.swift
//  EPersonnelAssistant
//
//  Created by GSK on 2/2/21.
//

import UIKit
import Firebase
import MapKit
import CoreLocation


class UserDashBoardViewController: UIViewController, CLLocationManagerDelegate , UITableViewDataSource, UITableViewDelegate{
    
    let departmentArray = ["Danyal", "Billal", "Abubakar", "Sarwar"]
    

    var ref : DatabaseReference!
    var timer = Timer()
    
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
    
    let  hiNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Hi"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let  updateStatusLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Update Status"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notificationBellButton : UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(notificationButtonHandle), for: .touchUpInside)
        //let image = UIImage(named: "notification_icon")?.withRenderingMode(.alwaysOriginal)
        //button.setImage(UIImage(cgImage: image as! CGImage), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let timerCardView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        //view.layer.shadowPath = CGPath(rect: <#T##CGRect#>, transform: <#T##UnsafePointer<CGAffineTransform>?#>)
        //view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(r: 188, g: 188, b: 188).cgColor
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let  goodMorningLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Good Morning"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let  todayLabel :UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 141, g: 141, b: 141)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Today is Monday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let  startTimeLabel :UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 141, g: 141, b: 141)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "09:00 AM"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let  endTimeLabel :UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 141, g: 141, b: 141)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "06:00 PM"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let clockImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "c_lock")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let  currentTimeLabel :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        //label.text = "08:59:15"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let  timeLabel :UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 141, g: 141, b: 141)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkInOutButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(animationCircle), for: .touchUpInside)
        button.addTarget(self, action: #selector(tick), for: .touchUpInside)
        button.addTarget(self, action: #selector(checkInOutHandle), for: .touchUpInside)
        button.addTarget(self, action: #selector(mapIn), for: .touchUpInside)
        button.layer.cornerRadius = 50/2
        button.layer.backgroundColor = UIColor.systemGreen.cgColor
        button.setTitle("Chek In", for: .normal)
        //button.setTitle("Chek Out", for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func userIn() {
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
    
    let departmentTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(DepartmentCell.self, forCellReuseIdentifier: "cellId")
        //tableView.rowHeight = 100
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
//    let bottomNavigationMenuCollectionView : UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.register(BottomMenuCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
//        collectionView.backgroundColor = UIColor(r: 188, g: 188, b: 188)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        departmentTableView.dataSource = self
        departmentTableView.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        //view.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        

        
        let notificationIcon = UIImage(named: "notification_icon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: notificationIcon, style: .plain, target: self, action: #selector(notificationButtonHandle))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutHandle))
        // Do any additional setup after loading the view.
        mainSubViewsSetup()
        
        viewCircle()
        locationPermission()
        
        let oLat = 33.644541
        let oLong = 73.022366
        let centerR = CLLocationCoordinate2D(latitude: oLat, longitude: oLong)
        createLocalNotification(id: "1", title: "Location", body: "arrived", center: centerR, radius: 500, repeats: true)
        
        ceckIfUserLoggedIn()
        
        
    }
    //MARK:-DidMemoryWarning
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
//            let label = UILabel()//(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
//        let imageIcon = UIImage()
//
//            label.text = "TEST TEXT"
//        imageIcon.images = UIImage(named: "department_24_icon")
//
//            self.view.addSubview(view)

            return "Department"//view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DepartmentCell
        cell.memberNameLabel.text = departmentArray[indexPath.row]
        return cell
    }
    
    //MARK:- Time Format
    var time = String()
    var date = String()
    var hourOnly: String = ""
    var mintOnly: String = ""
    var secOnly: String = ""
    var dayOnly: String = ""
    @objc func tick() {
        let calendar = Calendar.current
        let hours    = calendar.component(.hour, from: Date())
        let minutes  = calendar.component(.minute, from: Date())
        let seconds  = calendar.component(.second, from: Date())
        let cal = calendar.component(.calendar, from: Date())
        
        
        print(cal, "+++++++++++++++++++++++++++++++++++++++++++++++++")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:m:s a"
        time = dateFormatter.string(from: Date())
        currentTimeLabel.text = time
        
        let hourFormat = DateFormatter()
        hourFormat.dateFormat = "HH"
        hourOnly = hourFormat.string(from: Date())
        print("hours:",hourOnly)
        
        let mintFormat = DateFormatter()
        mintFormat.dateFormat = "mm"
        mintOnly = mintFormat.string(from: Date())
        print("Mints:",mintOnly)
        
        let secFormat = DateFormatter()
        secFormat.dateFormat = "ss"
        secOnly = secFormat.string(from: Date())
        print("seconds:",secOnly)
        
        
        
        let currentDate = DateFormatter()
        currentDate.dateFormat = "dd-MM-yyyy"
        date = currentDate.string(from: Date())
        
        let dayFormat = DateFormatter()
                dayFormat.dateFormat = "eeee"
                dayOnly = dayFormat.string(from: Date())
                print("day:",dayOnly)
                todayLabel.text = "Today is \(dayOnly) \n \(date)"

//        dateFormatter.amSymbol = "AM"
//        dateFormatter.pmSymbol = "PM"

        let dateString = dateFormatter.string(from: Date())
        //print(dateString)
        //currentTimeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        //currentTimeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
    }
    
    //MARK:- Location Management
    let locationManager = CLLocationManager()
    
    
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    func locationPermission() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        //MKCircle(centerCoordinate coord: CLLocationCoordinate2D, radius: CLLocationDistance)
        
//        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)//(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
//
//        let rad = CLLocationDistance(10000)
//
//        MKCircle(center: center, radius: rad)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lat = locValue.latitude
        long = locValue.longitude
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        print("Lati...:", lat)
        print("longi...:", long)
        
//        goodMorningLabel.numberOfLines = 0
//        goodMorningLabel.text = String(lat)
//        goodMorningLabel.text = goodMorningLabel.text! + " \\ " + String(long)
        
    }


    
    var rad = CLLocationDistance()
    let officeLat = 33.667155//33.644541
    let officeLong = 75.897987//73.022366
    
    @objc func checkInOutHandle(){
        let center = CLLocationCoordinate2D(latitude: officeLat, longitude: officeLong)//(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)

        rad = CLLocationDistance(10000)

        MKCircle(center: center, radius: rad)
        let geoRegion = CLCircularRegion(center: center, radius: 500, identifier: "notify me:")
        
        geoRegion.notifyOnEntry = true
        geoRegion.notifyOnExit = true
        
        locationManager.startMonitoring(for: geoRegion)
        
//        if (officeLat == "33.234432" && officeLong = "75.897987"){
//            //Office
//        } else {
//            //Message Throw
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("user inside...")
        checkInOutHandle()
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("user going outside...")
        checkInOutHandle()
    }
    func createLocalNotification(id: String, title: String, body: String, center: CLLocationCoordinate2D, radius: CLLocationDistance, repeats: Bool) {
        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let region = CLCircularRegion(center: center, radius: radius, identifier: id)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger  = UNLocationNotificationTrigger(region: region, repeats: repeats)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    

    // MARK: - Navigation
    
    func ceckIfUserLoggedIn(){
        //user not login
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(logoutHandle), with: nil, afterDelay: 0)
            //handleLogout()
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {[self](snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    let nameString = dictionary["Name"] as? String
                    print("user Name:", nameString)
                    navigationItem.title = nameString
                }
            }, withCancel: nil)

        }
    }
    @objc func logoutHandle(){
        print("Logout Pressed ...")
        do{
            try Auth.auth().signOut()
            perform(#selector(showLoginScreen), with: nil, afterDelay: 0.01)
        } catch let logoutError {
            print("Error:-", logoutError)
        }
    }
//    fileprivate func isLoggedIn() -> Bool {
//        return UserDefaults.standard.bool(forKey: "alreadyLoggedIn")
//    }
    @objc func showLoginScreen(){
        let loginController = LoginViewController()
        //navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(LoginViewController(), animated: true)
        //present(loginController, animated: true, completion: nil)
    }
    

    @objc func notificationButtonHandle(){
        print("Notification Pressed ...")
    }
    
    
    
    //MARK:- Animations circle
    let shapeLayer = CAShapeLayer()//
    let trackLayer = CAShapeLayer()// used for mid underline
    let lateTrackLayer = CAShapeLayer() //late redLine
    let circleView = UIView()
    
    let indicatorLayer = CALayer()//egg indicator
    var eggPath = UIBezierPath()
    let indicatorAnimation = CAKeyframeAnimation(keyPath: "position")
    
    @objc func viewCircle() {
        
        
        let center = circleView.center
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -(3*CGFloat.pi/2), endAngle: 2 * CGFloat.pi, clockwise: true) //BackGround full Circle Gray color
        let circularPathLine = UIBezierPath(arcCenter: center, radius: 100, startAngle: -(4 * CGFloat.pi / 3), endAngle: -(5 * CGFloat.pi / 3), clockwise: true) //GreenLinePath
        //let circularPath = UIBezierPath(arcCenter: center, radius: 125, startAngle: 2 * CGFloat.pi / 3, endAngle: CGFloat.pi / 3, clockwise: true)
        
        
        //creating background track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor //inside color
        trackLayer.strokeColor = UIColor(r: 188, g: 188, b: 188).cgColor//outline
        trackLayer.lineWidth = 1
        trackLayer.lineCap = .round
        //trackLayer.lineCap
        trackLayer.shadowColor = UIColor(r: 190, g: 190, b: 190).cgColor
        trackLayer.shadowOffset = CGSize(width: 0, height: 0)//direction from center -OR(angle)
        trackLayer.shadowRadius = 8//shadow spred
        circleView.layer.addSublayer(trackLayer)
        
        //path for objects
        eggPath = circularPathLine
        shapeLayer.path = circularPathLine.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        //bgCircle View Complete
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor//outline
        shapeLayer.lineWidth = 7
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        circleView.layer.addSublayer(shapeLayer)
        
        ///Late chekinfill
        lateTrackLayer.path = circularPathLine.cgPath
        lateTrackLayer.fillColor = UIColor.clear.cgColor
        
        //bgCircle View Complete . late chekin Red
        lateTrackLayer.strokeColor = UIColor.systemRed.cgColor//outline
        lateTrackLayer.lineWidth = 7
        lateTrackLayer.strokeEnd = 0
        lateTrackLayer.lineCap = .round
        circleView.layer.addSublayer(lateTrackLayer)
        
        
        
        
        indicatorLayer.isHidden = true
        indicatorLayer.bounds = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
        indicatorLayer.cornerRadius = 10.0
        indicatorLayer.backgroundColor = UIColor(r: 190, g: 190, b: 190).cgColor
        indicatorLayer.borderWidth = 2
        indicatorLayer.borderColor = UIColor.red.cgColor
        lateTrackLayer.addSublayer(indicatorLayer)
        indicatorAnimation.path = circularPathLine.cgPath
        
    }
//    var hourOnly: String = ""
//    var mintOnly: String = ""
//    var secOnly: String = ""
    var h : String = ""
    var m : String = ""
    var s : String = ""
    
    
    let animationTime = CGFloat()
    
    let animationSeconds : CGFloat = 1/32400 // (1/60)//Total 9 hours in 32400 sec
    var toAn1 = CGFloat()
    
    var during = CGFloat()
    //let egg = during.self
    
    var hh = CGFloat()
    var mm = CGFloat()
    var ss = CGFloat()
    
    @objc func animationCircle() {
        guard let n1 = NumberFormatter().number(from: hourOnly) else { return }
        print("vale n1", n1)
        guard let n2 = NumberFormatter().number(from: mintOnly) else { return }
        print("vale n2", n2)
        guard let n3 = NumberFormatter().number(from: secOnly) else { return }
        print("vale n", n3)
        
        hh = CGFloat(truncating: n1) * 60
        mm = (hh + CGFloat(truncating: n2)) * 60
        ss = mm + CGFloat(truncating: n2) - 32400  //total time in seconds
        print("ss:", ss)
        
        let fromPoint : CGFloat = ss * animationSeconds
        let newFromPoint : CGFloat = animationSeconds - fromPoint
        let toPoint : CGFloat = 1
        let durationAll : CGFloat = 32400
        let durationRemain : CGFloat = 32400 - ss
        let durationLate : CGFloat = 32400 - ss
        
        var hours_n1 = CGFloat(truncating: n1)
        
        if hours_n1 >= 09 && hours_n1 <= 20 {
            print("time found@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            
        }else{print("no time found..........................................")}
        
        toAn1 = (CGFloat(truncating: n3) * animationSeconds)
        let newStart = animationSeconds - toAn1
        let lengthAnim = 60 - CGFloat(truncating: n3)
        during = lengthAnim
        print("length:", lengthAnim, "dur:", during)
        
        
        let lateRed = toAn1
        
        print(time)
        print(date)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = fromPoint//toAn1//0
        basicAnimation.toValue = 1//end animation
        basicAnimation.duration = CFTimeInterval(durationRemain)//(lengthAnim)//9//32400s=9h //Duration of animation
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards//
        basicAnimation.isRemovedOnCompletion = false//animation stay complete status
        shapeLayer.add(basicAnimation, forKey: "animation circle")
        
        let lateAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lateAnimation.fromValue = 0//toAn1//0
        lateAnimation.toValue = fromPoint//lateRed//1//end animation
        lateAnimation.duration = 0.5//CFTimeInterval(lengthAnim)//9//32400s=9h //Duration of animation
        lateAnimation.fillMode = CAMediaTimingFillMode.forwards//
        lateAnimation.isRemovedOnCompletion = false//animation stay complete status
        lateTrackLayer.add(lateAnimation, forKey: "animation circle")
        
        
        //egg animation
        
        indicatorLayer.isHidden = false
        
        indicatorAnimation.duration = 10//CFTimeInterval(durationRemain)//10.0//seconds
        //indicatorAnimation.path = circularPathLine.cgPath
    //indicatorAnimation.calculationMode = CAAnimationCalculationMode.paced
        indicatorAnimation.repeatCount = Float.greatestFiniteMagnitude
        indicatorLayer.add(indicatorAnimation, forKey: "position")
        
    }
    
    //Seconds clock
    func animateCAShapeLayerDrawing(){
            let layer = CAShapeLayer()
            let path = CGMutablePath()
            let centerPoint = CGPoint(x: 0, y: 0)
            path.addArc(center: centerPoint, radius: 100, startAngle: -CGFloat(Double.pi) / 2, endAngle: 3 * (CGFloat(Double.pi) / 2), clockwise: false)
            layer.path = path
            layer.strokeColor = UIColor.black.cgColor
            layer.lineWidth = 5.0
            layer.fillColor = nil
            shapeLayer.addSublayer(layer)
            
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 60.0//seconds
            pathAnimation.fromValue = 0.0
            pathAnimation.toValue = 1.0
            pathAnimation.repeatCount = Float.greatestFiniteMagnitude
            layer.add(pathAnimation, forKey: "strokeEndAnimation")

            let indicatorLayer = CALayer()
            indicatorLayer.bounds = CGRect(x: 0, y: 0, width: 10.0, height: 10.0)
            indicatorLayer.cornerRadius = 5.0
            indicatorLayer.backgroundColor = UIColor.red.cgColor
        shapeLayer.addSublayer(indicatorLayer)
            let indicatorAnimation = CAKeyframeAnimation(keyPath: "position")
            indicatorAnimation.duration = 60.0//seconds
            indicatorAnimation.path = path
        indicatorAnimation.calculationMode = CAAnimationCalculationMode.paced
            indicatorAnimation.repeatCount = Float.greatestFiniteMagnitude
            indicatorLayer.add(indicatorAnimation, forKey: "position")
        }
    
    //MARK:- UI Constraints Setup
    func mainSubViewsSetup() {
        // x, y, width, height
        view.addSubview(mainBackGroundView)
        
        NSLayoutConstraint.activate([mainBackGroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        mainBackGroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        mainBackGroundView.widthAnchor.constraint(equalToConstant: view.frame.width),
        mainBackGroundView.heightAnchor.constraint(equalToConstant: view.frame.height)])
        
        //scroll sub View
        mainBackGroundView.addSubview(mainScrollView)
        
        mainBackGroundView.addSubview(hiNameLabel)
        mainBackGroundView.addSubview(updateStatusLabel)
        mainBackGroundView.addSubview(notificationBellButton)
        
        NSLayoutConstraint.activate([hiNameLabel.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 15),
                                     hiNameLabel.topAnchor.constraint(equalTo: mainBackGroundView.topAnchor, constant: 30),
                                     hiNameLabel.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -70)])
        
        NSLayoutConstraint.activate([updateStatusLabel.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 15),
                                     updateStatusLabel.topAnchor.constraint(equalTo: hiNameLabel.bottomAnchor, constant: 4),
                                     updateStatusLabel.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -70),
                                     //updateStatusLabel.heightAnchor.constraint(equalToConstant: view.frame.height),
        
                                     
                                     notificationBellButton.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor, constant: -15),
                                     notificationBellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                                     notificationBellButton.widthAnchor.constraint(equalToConstant: 24),
                                     notificationBellButton.heightAnchor.constraint(equalToConstant: 24)])
        
        
        
        timerCardViewSetup()
    }
    func timerCardViewSetup() {
        mainBackGroundView.addSubview(timerCardView)
        
        timerCardView.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 15).isActive = true
        timerCardView.topAnchor.constraint(equalTo: mainBackGroundView.topAnchor, constant: 100).isActive = true
        timerCardView.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor , constant: -15).isActive = true
        timerCardView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        
        circleView.backgroundColor = UIColor.blue
        circleView.translatesAutoresizingMaskIntoConstraints = false
        timerCardView.addSubview(circleView)
        
        circleView.centerXAnchor.constraint(equalTo: timerCardView.centerXAnchor, constant: 0).isActive = true
        circleView.centerYAnchor.constraint(equalTo: timerCardView.centerYAnchor, constant: 0).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        timerCardComponentsView()
        departmentViewSetup()
    }
    
    func timerCardComponentsView() {
        timerCardView.addSubview(goodMorningLabel)
        timerCardView.addSubview(todayLabel)
        timerCardView.addSubview(startTimeLabel)
        timerCardView.addSubview(endTimeLabel)
        timerCardView.addSubview(checkInOutButton)
        
        timerCardView.addSubview(clockImageView)
        timerCardView.addSubview(currentTimeLabel)
        timerCardView.addSubview(timeLabel)
        
        goodMorningLabel.leadingAnchor.constraint(equalTo: timerCardView.leadingAnchor, constant: 15).isActive = true
        goodMorningLabel.topAnchor.constraint(equalTo: timerCardView.topAnchor, constant: 20).isActive = true
        goodMorningLabel.trailingAnchor.constraint(equalTo: timerCardView.trailingAnchor , constant: -15).isActive = true
        //timerCardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        todayLabel.leadingAnchor.constraint(equalTo: timerCardView.leadingAnchor, constant: 15).isActive = true
        todayLabel.topAnchor.constraint(equalTo: goodMorningLabel.bottomAnchor, constant: 5).isActive = true
        todayLabel.trailingAnchor.constraint(equalTo: timerCardView.trailingAnchor , constant: -15).isActive = true
        
        ////////////////////////
        clockImageView.centerXAnchor.constraint(equalTo: timerCardView.centerXAnchor, constant: 0).isActive = true
        clockImageView.bottomAnchor.constraint(equalTo: currentTimeLabel.topAnchor, constant: -20).isActive = true
        clockImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        clockImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        ////////////////////////////
        currentTimeLabel.centerXAnchor.constraint(equalTo: timerCardView.centerXAnchor, constant: 0).isActive = true
        currentTimeLabel.centerYAnchor.constraint(equalTo: timerCardView.centerYAnchor, constant: 0).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        ////////////////////////////
        timeLabel.centerXAnchor.constraint(equalTo: timerCardView.centerXAnchor, constant: 0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 20).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        ////////////////////////////
        
        
        //Chek in / out
        checkInOutButton.leadingAnchor.constraint(equalTo: timerCardView.leadingAnchor, constant: 70).isActive = true
        checkInOutButton.bottomAnchor.constraint(equalTo: timerCardView.bottomAnchor, constant: -20).isActive = true
        checkInOutButton.trailingAnchor.constraint(equalTo: timerCardView.trailingAnchor , constant: -70).isActive = true
        checkInOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        startTimeLabel.trailingAnchor.constraint(equalTo: timerCardView.centerXAnchor, constant: -75).isActive = true
        startTimeLabel.bottomAnchor.constraint(equalTo: checkInOutButton.topAnchor, constant: -30).isActive = true
        startTimeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        endTimeLabel.leadingAnchor.constraint(equalTo: timerCardView.centerXAnchor, constant: 75).isActive = true
        endTimeLabel.bottomAnchor.constraint(equalTo: checkInOutButton.topAnchor, constant: -30).isActive = true
        endTimeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //animateCAShapeLayerDrawing()
    }
    
    func departmentViewSetup() {
        mainBackGroundView.addSubview(departmentTableView)
        
        departmentTableView.leadingAnchor.constraint(equalTo: mainBackGroundView.leadingAnchor, constant: 15).isActive = true
        departmentTableView.topAnchor.constraint(equalTo: timerCardView.bottomAnchor, constant: 15).isActive = true
        departmentTableView.trailingAnchor.constraint(equalTo: mainBackGroundView.trailingAnchor , constant: -15).isActive = true
        //departmentTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        departmentTableView.bottomAnchor.constraint(equalTo: mainBackGroundView.bottomAnchor, constant: -15).isActive = true
        
    }
    
    @objc func mapIn() {
        let officeLatitude = 33.644538
        let officeLongitude = 73.022385//441589
        
        let areaRange = 0.000100
        let officeLatitude_A = officeLatitude - (areaRange/2)
        let officeLongitude_B = officeLongitude - (areaRange/2)
        
        let officeLatitudeA = officeLatitude + (areaRange/2)
        let officeLongitudeB = officeLongitude + (areaRange/2)
        
        //33.64452070484067 73.02237621360439
        print("My long", long)
        let userLatitude = lat//33.644400
        let userLongitude = long//73.022300
        
        if userLatitude >= officeLatitude_A && userLatitude <= officeLatitudeA{
            print("user is in office")
            if userLongitude >= officeLongitude_B && userLongitude <= officeLongitudeB{
                print("and user Arrived in office")
                inOutButtonChange(checkInOutButton)
                
            }else {
                print("and user is not comming")
            }
            
        } else {
            print("user is Absent")
        }
    }
    
    func inOutButtonChange(_ sender: AnyObject){
        
        if let button = sender as? UIButton
            {
                button.isSelected = !button.isSelected

                if (button.isSelected)
                {
                    button.backgroundColor = UIColor.red
                    button.setTitle("Chek Out", for: .normal)
                    attendenceOutTimeUpload()
                    
                }
                else
                {
                    button.backgroundColor = UIColor.systemGreen
                    button.setTitle("Chek In", for: .normal)
                    attendenceUpload()
                }
            }
        //checkInOutButton.backgroundColor
    }
    
    func attendenceUpload(){
        //user not login
//        if Auth.auth().currentUser?.uid == nil {
//            //perform(#selector(logoutHandle), with: nil, afterDelay: 0)
//            //handleLogout()
//            print("Unauthorized person")
//        }
        

//        Auth.auth().createUser(withEmail: email, password: password, completion: {[self](userData, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            guard let uid = userData?.user.uid else {return}
//            ref = Database.database().reference()
//            let usersRef = ref.child("users").child(uid)
//
//            let values = ["Name": name, "Email": email, "Number": number, "Department": department, "Password": password, "RePassword": rePassword]
//            usersRef.updateChildValues(values as [AnyHashable : Any], withCompletionBlock: {[self](err, ref) in
//                if err != nil {
//                    print(err!)
//                    return
//                }
//                print("saved user Successfully in cloud")
//                dismiss(animated: true, completion: nil)
//            })
        let values = ["In ": time, "Date": date]
        
        guard let uidWrite = Auth.auth().currentUser?.uid else { return print("no user saved")}
        ref = Database.database().reference()
        let userUpdateRef = ref.child("Attendence").child(uidWrite).childByAutoId()
        userUpdateRef.updateChildValues(values as [AnyHashable : Any], withCompletionBlock: {[self](err, ref) in
            if err != nil {
                print(err!)
                return
            }
            print("saved chekin User")
        })
        
        
        
        
        //read attendence
//        let uidRead = Auth.auth().currentUser?.uid
//            Database.database().reference().child("users").child(uidRead!).observeSingleEvent(of: .value, with: {[self](snapshot) in
//                if let dictionary = snapshot.value as? [String : AnyObject] {
//                    let dateString = dictionary["Date"] as? String
//                    print("In Date:", dateString)
//                    navigationItem.title = dateString
//                }
//            }, withCancel: nil)
        
    }
    
    func attendenceOutTimeUpload(){
    
        let values = ["out ": time, "Date Out": date]
        
        guard let uidWrite = Auth.auth().currentUser?.uid else { return print("no user saved")}
        ref = Database.database().reference()
        let userUpdateRef = ref.child("Attendence").child(uidWrite).childByAutoId()
        userUpdateRef.updateChildValues(values as [AnyHashable : Any], withCompletionBlock: {[self](err, ref) in
            if err != nil {
                print(err!)
                return
            }
            print("saved chekout User")
        })
        
    }
    
//    func getWIFIInformation() -> [String:String]{
//        var informationDictionary = [String:String]()
//        let informationArray:NSArray? = CNCopySupportedInterfaces()
//        if let information = informationArray {
//            let dict:NSDictionary? = CNCopyCurrentNetworkInfo(information[0] as! CFStringRef)
//            if let temp = dict {
//                informationDictionary["SSID"] = String(temp["SSID"]!)
//                informationDictionary["BSSID"] = String(temp["BSSID"]!)
//                return informationDictionary
//            }
//        }
//
//        return informationDictionary
//    }
    
}// ENd ViewController


//class BottomMenuCollectionViewCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//class MyViewController : UIViewController {
//    @IBOutlet weak var currentTimeLabel: UILabel!
//
//    var timer = Timer()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
//    }
//
//    @objc func tick() {
//        currentTimeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
//    }
//}
