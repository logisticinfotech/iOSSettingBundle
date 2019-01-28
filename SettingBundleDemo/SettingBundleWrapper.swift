//
//  SettingBundleWrapper.swift
//  LISettingBundleDemo
//
//  Created by Vishal on 01/01/19.
//  Copyright © 2019 LogisticInfotech. All rights reserved.
//

import Foundation
class SettingBundleWrapper{
    
    struct SettingsBundleKeyConstant {
        static let BuildVersionKey = "kVersion"
        static let AppVersionKey = "kBuildNumber"
    }
    
    static let shared = SettingBundleWrapper()
    
    private init() {
        setMainBundle()
        configureSettingsBundle()
    }
    
    let userDefaults = UserDefaults.standard
    var mainBundleDict: [String: Any]?
    
    
    // Setting bundle register and set values of setting bundle in UserDefault preferences.
    
    func configureSettingsBundle() {
        
        guard let settingsBundle = Bundle.main.url(forResource: "Settings", withExtension:"bundle") else {
            print("Settings.bundle not found")
            return;
        }
        
        guard let settings = NSDictionary(contentsOf: settingsBundle.appendingPathComponent("Root.plist")) else {
            print("Root.plist not found in settings bundle")
            return
        }
        
        guard let preferences = settings.object(forKey: "PreferenceSpecifiers") as? [[String: AnyObject]] else {
            print("Root.plist has invalid format")
            return
        }
        
        var defaultsToRegister = [String: AnyObject]()
        
        for var pref in preferences {
            if let key = pref["Key"] as? String, let val = pref["DefaultValue"] {
                print("\(key)==> \(val)")
                defaultsToRegister[key] = val
            }
        }
        
        userDefaults.register(defaults: defaultsToRegister)
        userDefaults.synchronize()
    }
 
    func setMainBundle() {
        if mainBundleDict == nil {
            if let dict = Bundle.main.infoDictionary {
                mainBundleDict = dict
            }
        }
    }

    //Setting the Application build info from the infoPlist into the settings app
    //Make sure the names for the keys is perfect as assign in Setting bundle plist.
    
    func setBuildInfo() {
        guard let appVersion = mainBundleDict?[String(kCFBundleVersionKey)] as? String else { return }
        guard let appBuildNumber = mainBundleDict?["CFBundleShortVersionString"] as? String else { return }
        userDefaults.set(appVersion, forKey: SettingsBundleKeyConstant.AppVersionKey)
        userDefaults.set(appBuildNumber, forKey: SettingsBundleKeyConstant.BuildVersionKey)
    }
}
