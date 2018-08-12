//
//  AppDelegate.swift
//  ReferHelper
//
//  Created by XMZ on 07/04/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let preferences = UserDefaults.standard
        if ((preferences.object(forKey: "token")) == nil) {
            GoToWelcome()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let url = userActivity.webpageURL!
            //handle url and open whatever page you want to open.
            let type = url.pathComponents.last!
            let params = queryParameters(from: url)
            
            GoToSignup(params, type)
        }
        return true
    }
    
    func GoToWelcome() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let createAccountStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC = createAccountStoryboard.instantiateViewController(withIdentifier: "Welcome") as! WelcomeNavigationController
        self.window?.rootViewController = welcomeVC
        self.window?.makeKeyAndVisible()
    }
    
    func GoToSignup(_ params: [String:String], _ type:String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let createAccountStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signupFormVC = createAccountStoryboard.instantiateViewController(withIdentifier: "SignupForm") as! SignupFormViewController
        signupFormVC.email = params["email"]!
        signupFormVC.token = params["token"]!
        signupFormVC.type = type
        self.window?.rootViewController = signupFormVC
        self.window?.makeKeyAndVisible()
    }
    
    func queryParameters(from url: URL) -> [String: String] {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryParams = [String: String]()
        for queryItem: URLQueryItem in (urlComponents?.queryItems)! {
            if queryItem.value == nil {
                continue
            }
            queryParams[queryItem.name] = queryItem.value
        }
        return queryParams
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

