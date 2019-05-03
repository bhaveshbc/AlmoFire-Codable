//
//  AppDelegate.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 03/05/19.
//  Copyright © 2019 Bhavesh Chaudhari. All rights reserved.
//

import UIKit
import MBProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var UserInfo : UserInfo?
    var progressView = UIView()
    var displayLoader = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate {
    
    func setupProgressView() {
        progressView.frame = UIScreen.main.bounds
        progressView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let progress = MBProgressHUD.showAdded(to: progressView, animated: true)
        progress.animationType = .zoomOut
        progress.contentColor = UIColor.white
    }
    
    func addProgressView() {
     
        
        if !(self.window?.subviews.contains(progressView))! {
            if let currentWindow = self.window {
                currentWindow.addSubview(progressView)
            }
        }
    }
    
    func hideProgrssVoew() {
        if (self.window?.subviews.contains(progressView))! {
            progressView.removeFromSuperview()
        }
    }
}

