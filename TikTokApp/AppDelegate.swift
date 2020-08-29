//
//  AppDelegate.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/19.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          // ...
          return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
    }
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        changeNavigationBarColor()
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID //
        GIDSignIn.sharedInstance().delegate = self
        return true
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
     }
    
    // MARK: UISceneSession Lifecycle
    func changeNavigationBarColor() {
          // 全てのNavigation Barの色を変更する
          // Navigation Bar の背景色の変更
          UINavigationBar.appearance().barTintColor = tabBarColor.primary
          // Navigation Bar の文字色の変更
          UINavigationBar.appearance().tintColor = tabBarColor.secondary
          // Navigation Bar のタイトルの文字色の変更
          UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: tabBarColor.background]
      }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

