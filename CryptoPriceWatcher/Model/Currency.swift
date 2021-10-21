//
//  Currency.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-16.
//

import Foundation

protocol NameableCurrency {
    func getName() -> String
}

enum Currency: String, Codable, CaseIterable, NameableCurrency {
    case USD
    case EUR
    case GBP
    case CNY
    case CHF
    
    func getName() -> String {
        switch self {
        case .USD:
            return "United States Dollars"
        case .EUR:
            return "Euros"
        case .GBP:
            return "British Pounds"
        case .CNY:
            return "Chinese Yuans"
        case .CHF:
            return "Swiss Franc"
        }
        
    }
}

enum CryptoCurrency: String, Codable, CaseIterable, NameableCurrency {
    case BTC
    case ETH
    case DOGE
    case ADA
    case USDT
    case SOL
    case LTC
    case UNI
    case DOT
    case XLM
    
    func getName() -> String {
        switch self {
        case .BTC:
            return "Bitcoin"
        case .ETH:
            return "Ethereum"
        case .DOGE:
            return "Dogecoin"
        case .ADA:
            return "Cardano"
        case .USDT:
            return "Tether"
        case .SOL:
            return "Solana"
        case .LTC:
            return "Litecoin"
        case .UNI:
            return "Uniswap"
        case .DOT:
            return "Polkadot"
        case .XLM:
            return "Stellar"
        }
    }
}
