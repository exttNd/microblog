//
//  AppDelegate.swift
//  微博
//
//  Created by xm on 2018/3/17.
//  Copyright © 2018年 xm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor=UIColor.white
        window?.rootViewController=MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

