//
//  AppDelegate.swift
//  GoogleAd
//
//  Created by Limin Du on 8/27/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        var settings = UIUserNotificationSettings(forTypes:UIUserNotificationType.Badge|UIUserNotificationType.Alert|UIUserNotificationType.Sound, categories:nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        cancelLocalNotification()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        //For demo purpose, I'll send notification after 1 minute, 8 minutes and 27 minutes
        setLocalNotification(1)
        setLocalNotification(2)
        setLocalNotification(3)
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        cancelLocalNotification()
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, handleWatchKitExtensionRequest
        userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)?) {
            println("in handleWatchKitExtensionRequest")
            
            let info = userInfo as? [String: String]
            let command = info?["command"]
            if command != nil && command == "Refresh" {
                println("post kRefreshFMDBNotification")
                NSNotificationCenter.defaultCenter().postNotificationName("kRefreshFMDBNotification", object: nil)
                
                reply.map { $0(["response" : "success"]) }
                
            } else {
                reply.map { $0(["response" : "fail"]) }
            }
    }

    func setLocalNotification(num:Int) {
        var unit = 60.0 //minutes
        var interval:NSTimeInterval = unit * Double(num) * Double(num) * Double(num)
        
        var noti = UILocalNotification()
        var now = NSDate()
        
        noti.fireDate = NSDate(timeInterval: interval, sinceDate: now)
        noti.alertBody = "It's time to notify you"
        noti.timeZone = NSTimeZone()
        noti.soundName = UILocalNotificationDefaultSoundName
        noti.applicationIconBadgeNumber = num
        UIApplication.sharedApplication().scheduleLocalNotification(noti)
    }

    func cancelLocalNotification() {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }

}

