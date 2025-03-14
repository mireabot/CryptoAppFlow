//
//  AssetRow.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct AssetRow: View {
    let name: String
    let quantity: Double
    let value: Double
    
    var body: some View {
        HStack(spacing: 6) {
            // First letter with background
            Text(String(name.prefix(1)))
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(.gray.opacity(0.3))
                .clipShape(Circle())
            
            // Asset info
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                Text(String(format: "%.2f", quantity))
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            // Value
            Text("$" + String(format: "%.0f", value))
                .font(.headline)
        }
    }
}

#Preview {
    AssetRow(name: "Bitcoin", quantity: 0.5, value: 25000)
        .padding()
        .preferredColorScheme(.dark)
}
