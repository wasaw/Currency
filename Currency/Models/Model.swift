//
//  Modals.swift
//  Currency
//
//

import Foundation

enum CellType {
    case currency
    case favourite
    case alert
}

struct CurrencyModel {
    let title: String
    let shortTitle: String
    let price: Double
    let lastPrice: Double
    var volumeDay: Double
    var mktcap: Double
    var circulatingsupply: Double
}

struct CurrencyPreview {
    let title: String
    let shortTitle: String
    let price: String
    let difference: String
    let mktcap: String
    let volume: String
    let circul: String
    let isRevenue: Bool
    let isFavourite: Bool
}
