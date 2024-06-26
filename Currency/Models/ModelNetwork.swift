//
//  ModelNetwork.swift
//  Currency
//
//  Created by Александр Меренков on 25.06.2024.
//

import Foundation

// MARK: - CurrencyDataModel
struct CurrencyDataModel: Codable {
    let display: Display

    enum CodingKeys: String, CodingKey {
        case display = "DISPLAY"
    }
}

struct Display: Codable {
    let etc: DisplayEtc
    let btc: DisplayEtc
    let eth: DisplayEtc

    enum CodingKeys: String, CodingKey {
        case etc = "ETC"
        case btc = "BTC"
        case eth = "ETH"
    }
}

struct DisplayEtc: Codable {
    let usd: PurpleUSD

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

struct PurpleUSD: Codable {
    let fromsymbol, tosymbol, market, price: String
    let lastupdate, lastvolume, lastvolumeto, lasttradeid: String
    let volumeday, volumedayto, volume24Hour, volume24Hourto: String
    let openday, highday, lowday, open24Hour: String
    let high24Hour, low24Hour, lastmarket, volumehour: String
    let volumehourto, openhour, highhour, lowhour: String
    let toptiervolume24Hour, toptiervolume24Hourto, change24Hour, changepct24Hour: String
    let changeday, changepctday, changehour, changepcthour: String
    let conversiontype, conversionsymbol, conversionlastupdate, supply: String
    let mktcap, circulatingsupply: String
    let imageurl: String

    enum CodingKeys: String, CodingKey {
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case market = "MARKET"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case volumehour = "VOLUMEHOUR"
        case volumehourto = "VOLUMEHOURTO"
        case openhour = "OPENHOUR"
        case highhour = "HIGHHOUR"
        case lowhour = "LOWHOUR"
        case mktcap = "MKTCAP"
        case toptiervolume24Hour = "TOPTIERVOLUME24HOUR"
        case toptiervolume24Hourto = "TOPTIERVOLUME24HOURTO"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case circulatingsupply = "CIRCULATINGSUPPLY"
        case changehour = "CHANGEHOUR"
        case changepcthour = "CHANGEPCTHOUR"
        case conversiontype = "CONVERSIONTYPE"
        case conversionsymbol = "CONVERSIONSYMBOL"
        case conversionlastupdate = "CONVERSIONLASTUPDATE"
        case supply = "SUPPLY"
        case imageurl = "IMAGEURL"
    }
}
