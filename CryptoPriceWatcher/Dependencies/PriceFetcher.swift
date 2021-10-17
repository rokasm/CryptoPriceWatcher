//
//  PriceFetcher.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-12.
//

import Foundation

protocol Fetcher {
    func fetch(from: CryptoCurrency, to: Currency, response: @escaping (PriceResponse?) -> Void)
}

struct PriceFetcher: Fetcher {
    let network: Network
    init(network: Network) {
        self.network = network
    }
    
    func fetch(from: CryptoCurrency, to: Currency, response: @escaping (PriceResponse?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            network.request(from: ApiProviders.coinbase(from: from.rawValue, to: to.rawValue)) { data, error in
                if error != nil {
                    print("Error received requesting price")
                }
                guard let dataSource = data, let price = try? JSONDecoder().decode(PriceResponse.self, from: dataSource) else { return }
                response(price)
            
            }
        }
    }
}
