//
//  ModelNetwork.swift
//  Currency
//
//  Created by Александр Меренков on 25.06.2024.
//

import Foundation

// MARK: - CurrencyDataModel
struct CurrencyDataModel: Codable {
    let raw: Raw

    enum CodingKeys: String, CodingKey {
        case raw = "RAW"
    }
}

struct Raw: Codable {
    let etc: RawEtc
    let btc: RawEtc
    let eth: RawEtc
    
    enum CodingKeys: String, CodingKey {
        case etc = "ETC"
        case btc = "BTC"
        case eth = "ETH"
    }
}

struct RawEtc: Codable {
    let usd: RawUSD
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

struct RawUSD: Codable {
    let price: Double
    let openday: Double
    let volume24Hourto: Double
    let mktcap: Double
    let circulatingsupply: Double
    
    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case openday = "OPENDAY"
        case volume24Hourto = "VOLUME24HOURTO"
        case mktcap = "MKTCAP"
        case circulatingsupply = "CIRCULATINGSUPPLY"
    }
}
