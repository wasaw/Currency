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
