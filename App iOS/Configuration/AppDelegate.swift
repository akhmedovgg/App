//
//  AppDelegate.swift
//  App
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ExperimentalViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

