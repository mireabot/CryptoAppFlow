//
//  SwapAssetSelection.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/19/25.
//

import SwiftUI

struct SwapAssetSelection: View {
    @EnvironmentObject private var walletService: WalletService
    @Environment(\.dismiss) private var dismiss
    var onAssetSelected: (Asset) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(walletService.assets) { asset in
                    Button {
                        onAssetSelected(asset)
                        dismiss()
                    } label: {
                        assetCard(asset)
                    }
                }
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select asset")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    private func assetCard(_ asset: Asset) -> some View {
        HStack {
            Text(String(asset.name.prefix(1)))
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(.gray.opacity(0.3))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(asset.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(String(format: "%.1f", asset.amount))
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("$" + String(format: "%.0f", asset.valueInUSD))
                .font(.headline)
                .foregroundStyle(.white)
        }
        .foregroundStyle(.primary)
        .padding(12)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationStack {
        SwapAssetSelection { asset in
            print("Selected asset: \(asset.name)")
        }
        .environmentObject(WalletService())
    }
    .preferredColorScheme(.dark)
}
