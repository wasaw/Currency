//
//  CurrencyService.swift
//  Currency
//
//

import Foundation

final class CurrencyService: CurrencyServiceProtocol {
    static let shared = CurrencyService()
    
// MARK: - Properties
    
    private let coreData = CoreDataService.shared
}

// MARK: - Private API

private extension CurrencyService {
    func formatNumber(_ number: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number))
    }
    
    func abbreviateNumber(_ number: Double) -> String {
        let abbrev = ["", "K", "M", "B", "T", "P", "E"]

        var num = number
        var index = 0

        while num >= 1000 && index < abbrev.count - 1 {
            num /= 1000
            index += 1
        }

        if let formattedNumber = formatNumber(num) {
            return "\(formattedNumber)\(abbrev[index])"
        } else {
            return "\(number)"
        }
    }
}

// MARK: - Public API

extension CurrencyService {
    func fetchCurrency() -> [CurrencyPreview]? {
        var exchangeRate: [CurrencyPreview] = []
        
        do {
            let currencyManagedObject = try coreData.fetchCurrency()
            exchangeRate = currencyManagedObject.compactMap({ currency in
                guard let title = currency.title,
                      let shortTitle = currency.shortTitle,
                      let price = formatNumber(currency.price),
                      let difference = formatNumber(currency.difference) else { return nil }
                
                let isRevenue = ((currency.price - currency.lastPrice) > 0) ? true : false
                let sign = isRevenue ? "+" : ""
                
                return CurrencyPreview(title: title,
                                    shortTitle: shortTitle,
                                    price: "$" + price,
                                    difference: sign + difference + "%",
                                    mktcap: "$ " + abbreviateNumber(currency.mktcap),
                                    volume: "$ " + abbreviateNumber(currency.volumeDay),
                                    circul: shortTitle + " " + abbreviateNumber(currency.circul),
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
        var exchangeRate: [CurrencyModel] = []
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETC,BTC,ETH&tsyms=USD") else { return }
        let request = URLRequest(url: url)
        Network().loadData(request: request) { (result: Result<CurrencyDataModel, Error>) in
            switch result {
            case .success(let result):
                exchangeRate.append(CurrencyModel(title: "Ethereum Classic",
                                                   shortTitle: "ETC",
                                                   price: result.raw.etc.usd.price,
                                                   lastPrice: result.raw.etc.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Bitcoin",
                                                   shortTitle: "BTC",
                                                   price: result.raw.btc.usd.price,
                                                   lastPrice: result.raw.btc.usd.openday,
                                                   volumeDay: result.raw.btc.usd.volume24Hourto,
                                                   mktcap: result.raw.btc.usd.mktcap,
                                                   circulatingsupply: result.raw.btc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Ethereum",
                                                   shortTitle: "ETH",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
            
                _ = exchangeRate.map { [weak self] currency in
                        self?.coreData.save { context in
                            let currencyManagedObject = CurrencyManagedObject(context: context)
                            let difference = ((currency.price - currency.lastPrice) / currency.price) * 100
                            currencyManagedObject.title = currency.title
                            currencyManagedObject.shortTitle = currency.shortTitle
                            currencyManagedObject.lastPrice = currency.lastPrice
                            currencyManagedObject.price = currency.price
                            currencyManagedObject.volumeDay = currency.volumeDay
                            currencyManagedObject.difference = difference
                            currencyManagedObject.mktcap = currency.mktcap
                            currencyManagedObject.circul = currency.circulatingsupply
                            currencyManagedObject.isFavourite = false
                        }
                }
            case .failure(_):
                break
            }
        }
    }
}
