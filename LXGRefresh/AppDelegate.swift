//
//  AppDelegate.swift
//  LXGRefresh
//
//  Created by 黎曦光 on 2018/4/16.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let viewController = ViewController()
        let navigationController = NavController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()
    }


}

