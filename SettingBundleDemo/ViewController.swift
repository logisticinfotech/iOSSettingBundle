//
//  ViewController.swift
//  SettingBundleDemo
//
//  Created by Vishal on 29/12/18.
//  Copyright © 2018 LogisticInfotech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblUserNameTitle: UILabel!
    @IBOutlet weak var lblUserNameValue: UILabel!
    
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblAddressValue: UILabel!
    
    var backGroundColor:UIColor = UIColor.white
    var fontColor:UIColor = UIColor.black
    var fontName:String = "Arial"
    var fontSize:CGFloat = 10
    var fullName = "N/A"
    var userAddress = "N/A"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LI Setting Bundle Demo"
        fetchSettingBundleData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchSettingBundleData), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func fetchSettingBundleData(){
        
        
        let userDefault = UserDefaults.standard
        //Fetch value from Setting bundle
        
        if userDefault.bool(forKey: "kDarkThene") {
            backGroundColor = UIColor.black
            fontColor = UIColor.white
        }
        else{
            backGroundColor = UIColor.white
            fontColor = UIColor.black
        }
        if let userName = userDefault.value(forKey: "kUserName") as? String{
            fullName = userName
        }
        if let addr = userDefault.value(forKey: "kUserAddress") as? String{
            userAddress = addr
        }
        if let tempFontName = userDefault.value(forKey: "kFontFamily") as? String{
            fontName = tempFontName
        }
        if let tempFontSize = userDefault.value(forKey: "kFontSize") as? CGFloat{
            fontSize = tempFontSize
        }
        print("fullName-->",fullName)
        print("userAddress-->",userAddress)
        print("fontName-->",fontName)
        print("fontSize-->",fontSize)
        self.setupUI()
    }
    
    @objc func setupUI(){
       
        self.view.backgroundColor = backGroundColor
        
        lblUserNameTitle.textColor = fontColor
        lblUserNameValue.textColor = fontColor
        lblAddressTitle.textColor = fontColor
        lblAddressValue.textColor = fontColor
        
        lblUserNameValue.text = fullName
        lblAddressValue.text = userAddress
        
        lblUserNameTitle.font = UIFont(name: fontName, size: fontSize)
        lblUserNameValue.font = UIFont(name: fontName, size: fontSize)
        lblAddressTitle.font = UIFont(name: fontName, size: fontSize)
        lblAddressValue.font = UIFont(name: fontName, size: fontSize)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
