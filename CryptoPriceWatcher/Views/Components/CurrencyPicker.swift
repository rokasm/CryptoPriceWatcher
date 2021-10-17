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
//    var action: () -> Void
    
    var body: some View {
        if (isVisible) {
            Picker("Select Currency", selection: $selectedValue) {
                ForEach(options, id: \.self) { option in
                    Text(option.getName())
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .semibold))
                        .tag(option)
                }
            }
            .onChange(of: selectedValue) { (value) in
                withAnimation {
                    print(value)
                    isVisible = false
                }
            }
            .background(
                ZStack() {
                    Color.black.opacity(0.5)
                    Image("Background").resizable().opacity(0.85)
                        .blendMode(BlendMode.overlay)
                }
                    .blur(radius: 10)
            )
            .labelsHidden()
            .pickerStyle(.wheel)
            .padding(0)
            .frame(width: 300, height: 150)
            .cornerRadius(25)
            .offset(x: offset.x, y: offset.y)
        }
    }
}
