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
}
