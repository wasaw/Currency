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
            
            var exchangeRate: [Currency] = []
            guard let url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETC,BTC,ETH&tsyms=USD") else { return }
            let request = URLRequest(url: url)
            Network().loadData(request: request) { (result: Result<CurrencyDataModel, Error>) in
                switch result {
                case .success(let result):
                    exchangeRate.append(Currency(title: "Ethereum Classic",
                                                       symbol: result.display.etc.usd.fromsymbol,
                                                       price: result.display.etc.usd.price,
                                                       lastPrice: result.display.etc.usd.openday))
                    exchangeRate.append(Currency(title: "Bitcoin",
                                                       symbol: result.display.btc.usd.fromsymbol,
                                                       price: result.display.btc.usd.price,
                                                       lastPrice: result.display.btc.usd.openday))
                    exchangeRate.append(Currency(title: "Ethereum",
                                                       symbol: result.display.eth.usd.fromsymbol,
                                                       price: result.display.eth.usd.price,
                                                       lastPrice: result.display.eth.usd.openday))
                
                    _ = exchangeRate.map { currency in
                        let priceString = currency.price.dropFirst()
                        let openDay = currency.lastPrice.dropFirst()
                        let str = priceString.replacingOccurrences(of: ",", with: "")
                        let strOpen = openDay.replacingOccurrences(of: ",", with: "")
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        formatter.locale = Locale(identifier: "en_US")

                        if let number = formatter.number(from: String(str)),
                           let openNumber = formatter.number(from: String(strOpen)){
                            CoreDataService().save { context in
                                let currencyManagedObject = CurrencyManagedObject(context: context)
                                currencyManagedObject.title = currency.title
                                currencyManagedObject.shortTitle = currency.symbol
                                currencyManagedObject.lastPrice = openNumber.doubleValue
                                currencyManagedObject.price = number.doubleValue
                                currencyManagedObject.isFavourite = false
                            }
                        }
                    }
                case .failure(_):
                    break
                }
            }
        }
        
        window?.makeKeyAndVisible()
    }

}

