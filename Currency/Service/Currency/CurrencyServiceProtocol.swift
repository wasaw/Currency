//
//  CurrencyServiceProtocol.swift
//  Currency
//
//

import Foundation

protocol CurrencyServiceProtocol: AnyObject {
    func fetchCurrency() -> [CurrencyPreview]?
    func loadCurrency()
}
