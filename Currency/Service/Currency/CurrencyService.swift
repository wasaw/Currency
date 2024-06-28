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
    
    func stringToDouble(_ string: String?) -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")

        guard let string = string else { return nil }
        if let number = formatter.number(from: string) {
            return number.doubleValue
        } else {
            return nil
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
                let alert = (currency.alert == 0) ? nil : formatNumber(currency.alert)
                let isPositiveAlert = (currency.price < currency.alert ) ? true : false
                
                return CurrencyPreview(title: title,
                                    shortTitle: shortTitle,
                                    price: "$" + price,
                                    difference: sign + difference + "%",
                                    mktcap: "$ " + abbreviateNumber(currency.mktcap),
                                    volume: "$ " + abbreviateNumber(currency.volumeDay),
                                    circul: shortTitle + " " + abbreviateNumber(currency.circul),
                                    alert: alert,
                                    isRevenue: isRevenue,
                                    isFavourite: currency.isFavourite,
                                    isPositiveAlert: isPositiveAlert)
            })
            
            return exchangeRate
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetchAlert() -> [AlertPreview]? {
        var alerts: [AlertPreview] = []
        
        do {
            let alertManagedObject = try coreData.fetchAlert()
            
            alerts = alertManagedObject.compactMap({ alert in
                guard let id = alert.id,
                      let alertPrice = formatNumber(alert.alert),
                      let price = formatNumber(alert.price),
                      let title = alert.title,
                      let shortTitle = alert.shortTitle else { return nil }
                
                let isPositiveAlert = (alert.price < alert.alert) ? true : false
                
                return AlertPreview(id: id,
                                    title: title,
                                    shortTitle: shortTitle,
                                    price: price,
                                    alert: alertPrice,
                                    isPositiveAlert: isPositiveAlert)
            })
            
            return alerts
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
                exchangeRate.append(CurrencyModel(title: "Tether",
                                                   shortTitle: "USDT",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Dogecoin",
                                                   shortTitle: "DOGE",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Cardano",
                                                   shortTitle: "ADA",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Chainlink",
                                                   shortTitle: "LINK",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Polkadot",
                                                   shortTitle: "DOT",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Polygon",
                                                   shortTitle: "MATIC",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Maker",
                                                   shortTitle: "MKR",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Monero",
                                                   shortTitle: "XMR",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Kaspa",
                                                   shortTitle: "KAS",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Litecoin",
                                                   shortTitle: "LTC",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Notcoin",
                                                   shortTitle: "NOT",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Theta",
                                                   shortTitle: "THETA",
                                                   price: result.raw.eth.usd.price,
                                                   lastPrice: result.raw.eth.usd.openday,
                                                   volumeDay: result.raw.etc.usd.volume24Hourto,
                                                   mktcap: result.raw.etc.usd.mktcap,
                                                   circulatingsupply: result.raw.etc.usd.circulatingsupply))
                exchangeRate.append(CurrencyModel(title: "Akash",
                                                   shortTitle: "AKT",
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
                            currencyManagedObject.alert = 0
                            currencyManagedObject.isFavourite = false
                        }
                }
            case .failure(_):
                break
            }
        }
    }
    
    func setAlert(text: String?, for currency: CurrencyPreview) {
        guard let value = stringToDouble(text?.lowercased()) else { return }
        coreData.save { [weak self] context in
            let alertManagedObject = AlertManagedObject(context: context)
            alertManagedObject.id = UUID()
            alertManagedObject.title = currency.title
            alertManagedObject.alert = value
            alertManagedObject.shortTitle = currency.shortTitle
            let price = currency.price.dropFirst().replacingOccurrences(of: ",", with: "")
            if let price = self?.stringToDouble(price) {
                alertManagedObject.price = price
            }
        }
    }
    
    func setLoad() {
        let number = Int.random(in: 4..<12)
        UserDefaults.standard.setValue(number, forKey: "number")
    }
    
    func updateAlert(text: String?, for alert: AlertPreview) {
        let text = text?.dropFirst()
        guard let value = stringToDouble(text?.lowercased()) else { return }
        
        CoreDataService.shared.updateAlert(value: value, for: alert.id)
    }
    
    func checkNotification() {
        let currency = fetchCurrency()
        let alert = fetchAlert()
        
        guard let currency = currency,
              let alert = alert else { return }
        
        currency.forEach { cash in
            alert.forEach { notif in
                if cash.title == notif.title && cash.price == notif.price {
                    ScheduleNotificationViewController().scheduleNotification(title: notif.title, body: "Достигнута цена", timeInterval: 5)
                }
            }
        }
    }
    
    func checkload() -> Bool {
        guard let number = UserDefaults.standard.value(forKey: "number") as? Int else { return false }
        let check = number - 1
        if check == 0 {
            return true
        } else {
            UserDefaults.standard.setValue(check, forKey: "number")
            return false
        }
    }
}
