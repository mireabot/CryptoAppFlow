//
//  WalletDashboard.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct WalletDashboard: View {
    @StateObject private var walletService = WalletService()
    @State private var selectedAssetType: AssetSegmentType = .all
    @State private var showSendFlow = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Balance Section
                    VStack(alignment: .leading, spacing: 8) {
                        BalanceItem(balance: walletService.publicBalance, type: .public)
                        BalanceItem(balance: walletService.privateBalance, type: .private)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Actions
                    HStack(spacing: 16) {
                        ActionButton(icon: Image(systemName: "dock.arrow.up.rectangle"), title: "Stake") {}
                        ActionButton(icon: Image(systemName: "arrow.up"), title: "Send") {
                            showSendFlow = true
                        }
                        ActionButton(icon: Image(systemName: "arrow.left.arrow.right"), title: "Swap") {}
                        ActionButton(icon: Image(systemName: "creditcard"), title: "Buy") {}
                    }
                    
                    // Assets Section
                    VStack(spacing: 16) {
                        AssetsSegmentControl(selection: $selectedAssetType, isEnabled: true)
                        
                        VStack(spacing: 12) {
                            ForEach(walletService.filteredAssets(by: selectedAssetType)) { asset in
                                AssetRow(name: asset.name, quantity: asset.amount, value: asset.valueInUSD)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .floatingSheet(isPresented: $showSendFlow) {
                SendFlowView(isPresented: $showSendFlow)
                    .environmentObject(walletService)
            }
        }
    }
}

#Preview {
    WalletDashboard()
        .preferredColorScheme(.dark)
}
