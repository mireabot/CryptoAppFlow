//
//  SwapTextFieldRow.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/19/25.
//

import SwiftUI

struct SwapTextFieldRow: View {
    @EnvironmentObject private var walletService: WalletService
    @Binding var value: String
    let asset: Asset
    let isEnabled: Bool
    @State private var showAssetSelection = false
    var onAssetSelected: ((Asset) -> Void)?
    
    private var valueInUSD: String {
        let amount = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0
        let total = amount * asset.valueInUSD
        return String(format: "%.2f", total)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                TextField("0.0", text: $value)
                    .font(.system(.title, weight: .semibold))
                    .keyboardType(.decimalPad)
                    .disabled(!isEnabled)
                
                Button {
                    showAssetSelection = true
                } label: {
                    HStack(spacing: 6) {
                        Text(String(asset.name.prefix(1)))
                            .font(.system(.footnote, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(.gray.opacity(0.3))
                            .clipShape(Circle())
                        
                        Text(asset.name)
                            .font(.system(.subheadline, weight: .semibold))
                        
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .background(.gray.opacity(0.2))
                    .clipShape(Capsule())
                }
                .foregroundStyle(.white)
            }
            
            HStack {
                Text("$\(valueInUSD)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text("Balance: \(asset.amount, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .floatingSheet(isPresented: $showAssetSelection) {
            NavigationView {
                SwapAssetSelection { selectedAsset in
                    onAssetSelected?(selectedAsset)
                }
                .environmentObject(walletService)
            }
        }
    }
}

#Preview {
    SwapTextFieldRow(value: .constant("0.02"), asset: WalletService().assets.first!, isEnabled: true)
        .environmentObject(WalletService())
        .preferredColorScheme(.dark)
}
