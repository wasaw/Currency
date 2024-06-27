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
        
        let isFirstLaunch = UserDefaults.standard.isFirstLaunch
        if isFirstLaunch {
            window?.rootViewController = UINavigationController(rootViewController: LoadingViewController())
            UserDefaults.standard.isFirstLaunch = false
            CurrencyService.shared.loadCurrency()
        } else {
            window?.rootViewController = TabBarContoller()
        }
        
        window?.makeKeyAndVisible()
    }

}

