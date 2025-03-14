//
//  SendFlow.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

enum SendFlowScreen {
    case recipients
    case assets
    case details
    case summary
}

struct SendFlowView: View {
    @StateObject private var contractService = ContractService()
    @EnvironmentObject private var walletService: WalletService
    @State private var path: [SendFlowScreen] = []
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack(path: $path) {
            RecipientsSelection(path: $path)
                .navigationDestination(for: SendFlowScreen.self) { screen in
                    switch screen {
                    case .recipients:
                        RecipientsSelection(path: $path)
                            .environmentObject(contractService)
                    case .assets:
                        AssetSelection(path: $path)
                            .environmentObject(contractService)
                    case .details:
                        ContractDetailsEntry(path: $path)
                            .environmentObject(contractService)
                    case .summary:
                        ContractSummaryView(path: $path, isPresented: $isPresented)
                            .environmentObject(contractService)
                    }
                }
                .environmentObject(contractService)
        }
    }
    
    private func resetPath() {
        path.removeAll()
    }
}

#Preview {
    SendFlowView(isPresented: .constant(true))
        .environmentObject(WalletService())
        .preferredColorScheme(.dark)
}
