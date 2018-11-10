//
//  AppDelegate.swift
//  PhotoSelect
//
//  Created by Michael Chirico on 11/10/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  // MARK: - Handle File Sharing
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    // We can do a lot more here...
    print("URL: ")
    
    switch url.pathExtension {
    case "sqlite":
      print("sqlite")
    case "Zsqlite":
      print("Zsqlite")
    case "photoSelect":
      print("photoSelect")
    default:
      return false
    }

    ViewController.importData(from: url)
    
    return true
  }
  
}
