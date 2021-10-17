//
// CryptoPriceWatcherView.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-12.
//

import SwiftUI

struct CryptoPriceWatcherView: View {
    @ObservedObject var viewModel  = CryptoPriceWatcherViewModel()
    @State var selectedCrypto: CryptoCurrency = CryptoCurrency.BTC
    @State var selectedFiat: Currency = Currency.USD
    @State var showCryptoSelection = false
    @State var showFiatSelection = false
    
    var body: some View {
        ZStack(){
            Image("Background")
                .offset(x:  viewModel.backgroundOffset.x * 75, y: viewModel.backgroundOffset.y * 75)
                .ignoresSafeArea()
            GeometryReader() { geometry in
                VStack {
                    VStack {
                        Text(selectedCrypto.getName())
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color("LightBlue"))
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .padding(.bottom, 96)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showCryptoSelection.toggle()
                                    showFiatSelection = false
                                }
                            }
                        CurrencyPicker(selectedValue: $selectedCrypto, isVisible: $showCryptoSelection, options: viewModel.cryptoCurrencies)
                            .onDisappear() {
                                viewModel.fetchPrice(from: self.selectedCrypto, to: self.selectedFiat)
                        }
                    }.zIndex(1)
                    Text(viewModel.amount)
                        .font(.system(size: 54, weight: .bold))
                        .foregroundColor(Color("LightBlue"))
                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                        .onTapGesture {
                            viewModel.fetchPrice(from: self.selectedCrypto, to: self.selectedFiat)
                        }
                    VStack {
                        Text(selectedFiat.getName())
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("LightBlue"))
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .padding(.bottom, 128)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showFiatSelection.toggle()
                                    showCryptoSelection = false
                                }
                            }
                        CurrencyPicker(selectedValue: $selectedFiat, isVisible: $showFiatSelection, options: viewModel.fiatCurrencies)
                            .onDisappear() {
                                viewModel.fetchPrice(from: self.selectedCrypto, to: self.selectedFiat)
                        }
                    }
                    .zIndex(2)
                }
                .foregroundColor(Color.white)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
