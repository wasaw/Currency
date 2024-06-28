//
//  CurrencyServiceProtocol.swift
//  Currency
//
//

import Foundation

protocol CurrencyServiceProtocol: AnyObject {
    func fetchCurrency() -> [CurrencyPreview]?
    func fetchAlert() -> [AlertPreview]?
    func loadCurrency()
    func setAlert(text: String?, for currency: CurrencyPreview)
    func updateAlert(text: String?, for alert: AlertPreview)
    func checkNotification()
}
