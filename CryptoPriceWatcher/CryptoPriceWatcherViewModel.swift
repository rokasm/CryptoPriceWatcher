//
//  CryptoPriceWatcherViewModel.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-13.
//

import Foundation
import Swinject
import CoreMotion

class CryptoPriceWatcherViewModel: ObservableObject {
    var fetcher: PriceFetcher
    @Published private(set) var price: Price?
    let motionManager = CMMotionManager()
    @Published var backgroundOffset: (x: Double, y: Double) = (x: 0.0, y: 0.0)
    @Published var cryptoCurrencies: [CryptoCurrency] = CryptoCurrency.allCases
    @Published var fiatCurrencies: [Currency] = Currency.allCases
   
    init() {
        let container = Container()

        container.register(ApiRequest.self) { _ in
          return ApiRequest()
        }
                
        container.register(PriceFetcher.self) { resolver in
            let network = resolver.resolve(ApiRequest.self)!
            return PriceFetcher(network: network)
        }
        fetcher = container.resolve(PriceFetcher.self)!
        fetchPrice(from: .BTC, to: .USD)
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
                self.backgroundOffset = (motion!.gravity.x, motion!.gravity.y)
            }
        }
    }
    
    func fetchPrice(from: CryptoCurrency, to: Currency ) {
        fetcher.fetch(from: from, to: to) { response in
            DispatchQueue.main.async {
                guard let response = response else { return }
                self.price = response.data
            }
        }
    }
    
    var amount: String {
        let dollars = price?.components().dollars ?? ""
        let cents = price?.components().cents ?? ""
        return dollars+"."+cents.prefix(2)
    }
    
    var cryptoName: String {
        price?.components().dollars ?? ""
    }
    
    var fiatName: String {
        price?.currency.getName() ?? ""
    }
        
    var currencyCode: String {
        price?.currency.rawValue ?? ""
    }
    
}
