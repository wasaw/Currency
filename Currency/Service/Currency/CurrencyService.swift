//
//  CurrencyService.swift
//  Currency
//
//

import Foundation

final class CurrencyService: CurrencyServiceProtocol {
    static let shared = CurrencyService()
}

// MARK: - Public API

extension CurrencyService {
    func fetchCurrency() -> [CurrencyPreview]? {
        var exchangeRate: [CurrencyPreview] = []
        
        do {
            let currencyManagedObject = try CoreDataService().fetchCurrency()
            exchangeRate = currencyManagedObject.compactMap({ currency in
                guard let title = currency.title,
                      let shortTitle = currency.shortTitle else { return nil }
                
                let price = "$" + String(currency.price)
                let result = ((currency.price - currency.lastPrice) / currency.price) * 100
                let isRevenue = ((currency.price - currency.lastPrice) > 0) ? true : false
                let sign = isRevenue ? "+" : ""
                let strDifference = sign + String(format: "%.2f", result) + "%"
                let strMktcap = String(format: "%.2f", currency.mktcap)
                let strVolume = String(format: "%.2f", currency.volumeDay)
                let strCircul = String(format: "%.2f", currency.circul)
                
                return CurrencyPreview(title: title,
                                    shortTitle: shortTitle,
                                    price: price,
                                    difference: strDifference,
                                    mktcap: strMktcap,
                                    volume: strVolume,
                                    circul: strCircul,
                                    isRevenue: isRevenue,
                                    isFavourite: currency.isFavourite)
            })
            
            return exchangeRate
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadCurrency() {
        var exchangeRate: [Currency] = []
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETC,BTC,ETH&tsyms=USD") else { return }
        let request = URLRequest(url: url)
        Network().loadData(request: request) { (result: Result<CurrencyDataModel, Error>) in
            switch result {
            case .success(let result):
                exchangeRate.append(Currency(title: "Ethereum Classic",
                                                   symbol: result.display.etc.usd.fromsymbol,
                                                   price: result.display.etc.usd.price,
                                                   lastPrice: result.display.etc.usd.openday,
                                                   volumeDay: result.display.etc.usd.volume24Hourto,
                                                   mktcap: result.display.etc.usd.mktcap,
                                                   circulatingsupply: result.display.etc.usd.circulatingsupply))
                exchangeRate.append(Currency(title: "Bitcoin",
                                                   symbol: result.display.btc.usd.fromsymbol,
                                                   price: result.display.btc.usd.price,
                                                   lastPrice: result.display.btc.usd.openday,
                                                   volumeDay: result.display.btc.usd.volume24Hourto,
                                                   mktcap: result.display.btc.usd.mktcap,
                                                   circulatingsupply: result.display.btc.usd.circulatingsupply))
                exchangeRate.append(Currency(title: "Ethereum",
                                                   symbol: result.display.eth.usd.fromsymbol,
                                                   price: result.display.eth.usd.price,
                                                   lastPrice: result.display.eth.usd.openday,
                                                   volumeDay: result.display.etc.usd.volume24Hourto,
                                                   mktcap: result.display.etc.usd.mktcap,
                                                   circulatingsupply: result.display.etc.usd.circulatingsupply))
                
            
                _ = exchangeRate.map { currency in
                    let priceString = currency.price.dropFirst()
                    let openDay = currency.lastPrice.dropFirst()
                    let volumeDay = currency.volumeDay.dropFirst()
                    let mktcapString = currency.mktcap.dropFirst().dropLast()
                    let circulatingsupplyString = currency.circulatingsupply.dropFirst().dropFirst().dropFirst()
                    let str = priceString.replacingOccurrences(of: ",", with: "")
                    let strOpen = openDay.replacingOccurrences(of: ",", with: "")
                    let strVolume = volumeDay.replacingOccurrences(of: ",", with: "")
                    let strMktcap = mktcapString.replacingOccurrences(of: ",", with: "")
                    let strCirculatingsupply = circulatingsupplyString.replacingOccurrences(of: ",", with: "")
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.locale = Locale(identifier: "en_US")

                    if let number = formatter.number(from: String(str)),
                       let openNumber = formatter.number(from: String(strOpen)),
                       let volumeNumber = formatter.number(from: String(strVolume)),
                       let mktcap = formatter.number(from: String(strMktcap)),
                       let circulatingsupplyNumber = formatter.number(from: String(strCirculatingsupply)) {
                        CoreDataService().save { context in
                            let currencyManagedObject = CurrencyManagedObject(context: context)
                            currencyManagedObject.title = currency.title
                            currencyManagedObject.shortTitle = currency.symbol
                            currencyManagedObject.lastPrice = openNumber.doubleValue
                            currencyManagedObject.price = number.doubleValue
                            currencyManagedObject.volumeDay = volumeNumber.doubleValue
                            currencyManagedObject.mktcap = mktcap.doubleValue
                            currencyManagedObject.circul = circulatingsupplyNumber.doubleValue
                            currencyManagedObject.isFavourite = false
                        }
                    }
                }
            case .failure(_):
                break
            }
        }
    }
}
