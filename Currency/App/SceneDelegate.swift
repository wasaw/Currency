//
//  SceneDelegate.swift
//  Currency
//
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        CurrencyService.shared.checkNotification()
        
        let isFirstLaunch = UserDefaults.standard.isFirstLaunch
        if isFirstLaunch {
            window?.rootViewController = UINavigationController(rootViewController: LoadingViewController())
            UserDefaults.standard.isFirstLaunch = false
            CurrencyService.shared.loadCurrency()
            requestNotificationAuthorization()
            CurrencyService.shared.setLoad()
        } else {
            if CurrencyService.shared.checkload() {
                window?.rootViewController = ClassicViewController()
            } else {
                window?.rootViewController = TabBarContoller()
            }
        }
        
        window?.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as? UNUserNotificationCenterDelegate
    }
    
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error)")
            }
            
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }

}

