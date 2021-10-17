//
//  EndPoint.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-14.
//

import Foundation

protocol Endpoint {
  var path: String { get }
}

enum ApiProviders: Endpoint {
    case coinbase(from: String, to: String)
    
  var path: String {
    switch self {
    case .coinbase(let from, let to): return "https://api.coinbase.com/v2/prices/\(from)-\(to)/spot"
    }
  }
}
