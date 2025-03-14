//
//  ContractSummary.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct ContractSummaryView: View {
    @EnvironmentObject private var contractService: ContractService
    @Environment(\.dismiss) private var dismiss
    @Binding var path: [SendFlowScreen]
    @Binding var isPresented: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Amount with USD conversion
                VStack(alignment: .center, spacing: 4) {
                    Text(String(format: "%.1f %@", contractService.contract.amount, contractService.contract.asset.symbol))
                        .font(.system(size: 40, weight: .bold))
                    
                    Text("$" + String(format: "%.2f", contractService.contract.valueInUSD))
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                
                // From section
                VStack(alignment: .leading, spacing: 32) {
                    summaryRow(
                        title: "FROM",
                        value: "WALLET",
                        detail: contractService.contract.senderAddress,
                        isPrivate: true
                    )
                    
                    // To section
                    summaryRow(
                        title: "TO",
                        detail: contractService.contract.recipientAddress ?? "",
                        isPrivate: true
                    )
                    
                    // Network details
                    summaryRow(
                        title: "NETWORK",
                        detail: contractService.contract.asset.network + " MAINNET"
                    )
                    
                    // Fee and ETA
                    summaryRow(
                        title: "FEE",
                        detail: "$" + String(format: "%.2f", contractService.contract.networkFee)
                    )
                    
                    summaryRow(
                        title: "ETA",
                        detail: contractService.contract.eta
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(16)
        }
        .safeAreaInset(edge: .bottom, content: {
            // Hold to send button
            HoldToSendButton {
                contractService.submitContract()
                isPresented = false
            }
            .padding(16)
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    private func summaryRow(title: String, value: String? = nil, detail: String, isPrivate: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if isPrivate {
                    Image(systemName: "lock.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Text("PRIVATE")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .opacity(isPrivate ? 1 : 0)
            }
            
            if let value {
                Text(value)
                    .kerning(0.5)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .font(.headline)
            }
            
            Text(detail)
                .kerning(0.5)
                .lineLimit(1)
                .truncationMode(.middle)
                .font(.headline)
        }
    }
}

#Preview {
    NavigationStack {
        ContractSummaryView(path: .constant([]), isPresented: .constant(false))
            .environmentObject(ContractService())
    }
    .preferredColorScheme(.dark)
}
