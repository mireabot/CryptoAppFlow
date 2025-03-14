//
//  CustomSheet.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/10/25.
//

import SwiftUI

struct FloatingSheetConfig {
    var maxDetent: PresentationDetent
    var cornerRadius: CGFloat = 20
    var interactiveDimiss: Bool = true
    var hPadding: CGFloat = 20
    var bPadding: CGFloat = 20
}

extension View {
    @ViewBuilder
    func floatingSheet<Content: View>(isPresented: Binding<Bool>, config: FloatingSheetConfig = .init(maxDetent: .fraction(0.99)), @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .sheet(isPresented: isPresented) {
                content()
                    .background(.background)
                    .clipShape(.rect(cornerRadius: config.cornerRadius))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .presentationDetents([config.maxDetent])
                    .presentationCornerRadius(0)
                    .presentationBackground(.clear.blendMode(.darken))
                    .presentationDragIndicator(.hidden)
                    .interactiveDismissDisabled(config.interactiveDimiss)
            }
    }
}
