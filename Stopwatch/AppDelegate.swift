//
//  AppDelegate.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/7/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController()

        window!.rootViewController = homeViewController

        // https://developer.apple.com/documentation/uikit/uiwindow/1621601-makekeyandvisible
        window!.makeKeyAndVisible()
        return true
    }
}
