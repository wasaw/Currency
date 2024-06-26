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

struct Currency {
    let title: String
    let symbol: String
    let price: String
    let lastPrice: String
    var isFavourite: Bool = false
    var volumeDay: String = ""
    var mktcap: String = ""
    var circulatingsupply: String = ""
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
