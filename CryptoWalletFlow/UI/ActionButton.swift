//
//  ActionButton.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct ActionButton: View {
    let icon: Image
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                icon
                    .font(.system(.title3))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 50)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Capsule())
                
                Text(title.uppercased())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ActionButton(
        icon: Image(systemName: "arrow.up"),
        title: "Send",
        action: {}
    )
    .preferredColorScheme(.dark)
}
