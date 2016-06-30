//
//  AppDelegate.swift
//  MixpanelNotificationTest
//
//  Created by Breathometer on 6/30/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import UIKit
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let mixpanel = Mixpanel.sharedInstance()

        print(UIDevice.currentDevice().systemVersion)
        if NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)) {
            // Ask for notification permission
            let settings = UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        } else {
            // For iOS 8 and lower
            let remoteNotificationTypes: UIRemoteNotificationType = [.NewsstandContentAvailability,.Badge, .Sound, .Alert]
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(remoteNotificationTypes)
        }
        
        mixpanel.identify("000000001")
        //        mixpanel.identify(mixpanel.distinctId)
        
        print("*** Ready to receive notifications... ***")
        
        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let mixpanel = Mixpanel.sharedInstanceWithToken(mixpanel_token)
        
        mixpanel.identify("000000001")
//        mixpanel.identify(mixpanel.distinctId)
        
        Mixpanel.sharedInstance().people.set(["$email": "kevin.hou@breathometer.com", "$distinct_id": "000000001"])
        
        Mixpanel.sharedInstance().people.addPushDeviceToken(deviceToken)
        print("Set device token")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("Received remote notification")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("Received remote notification")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

