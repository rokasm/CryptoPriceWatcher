//
//  Components.swift
//  CryptoPriceWatcher
//
//  Created by Rokas Mikelionis on 2021-10-16.
//

import SwiftUI

struct CurrencyPicker<CurrencyType>:View where CurrencyType:Hashable, CurrencyType:NameableCurrency {
    @Binding var selectedValue: CurrencyType
    @Binding var isVisible: Bool
    var options: [CurrencyType]
    var offset: (x: CGFloat, y: CGFloat) = (x: 0, y: -50)
    
    var body: some View {
        if (isVisible) {
            Picker("Select Currency", selection: $selectedValue) {
                ForEach(options, id: \.self) { option in
                    Text(option.getName())
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .regular))
                        .tag(option)
                }
            }
            .onChange(of: selectedValue) { (value) in
                withAnimation {
                    isVisible = false
                }
            }
            .background(
                ZStack() {
                    Image("Background").resizable()
                        .scaledToFill()
                        .blendMode(BlendMode.overlay)
                }
                    .blur(radius: 15)
                    .opacity(0.8)
            )
            .labelsHidden()
            .pickerStyle(.wheel)
            .padding(45)
            .frame(width: 300, height: 150)
            .cornerRadius(35)
            .offset(x: offset.x, y: offset.y)
            .transition(.opacity)
            .shadow(color: .black.opacity(0.75), radius: 30, x: 0, y: 0)
        }
    }
}
