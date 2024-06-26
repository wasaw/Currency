//
//  SceneDelegate.swift
//  Currency
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarContoller()
        
        let isFirstLaunch = UserDefaults.standard.isFirstLaunch
        if isFirstLaunch {
            UserDefaults.standard.isFirstLaunch = false
            
            CurrencyService.shared.loadCurrency()
        }
        
        window?.makeKeyAndVisible()
    }

}

