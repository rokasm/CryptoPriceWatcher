//
//  Price.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-14.
//

import Foundation

struct Price: Codable {
    let base: CryptoCurrency
    let amount: String
    let currency: Currency
}

extension Price {
    func components() -> (dollars: String?, cents: String?) {
        let tokens = amount.components(separatedBy: ".")

        return (dollars: tokens.first, cents: tokens.last)
    }
}
