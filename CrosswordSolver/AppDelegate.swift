//
//  AppDelegate.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import UIKit
import SwiftyBeaver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let log = SwiftyBeaver.self
    let console = ConsoleDestination()  // log to Xcode Console

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        console.format = "$DHH:mm:ss$d $L $M"
        log.addDestination(console)

        let m = MigrationService()
        m.setup()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: AppController())
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }
}
