//
//  ContractDetailsEntry.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct ContractDetailsEntry: View {
    @EnvironmentObject private var walletService: WalletService
    @EnvironmentObject private var contractService: ContractService
    @Environment(\.dismiss) private var dismiss
    @Binding var path: [SendFlowScreen]
    
    @State private var amount: String = ""
    
    private var isValidAmount: Bool {
        // If amount is empty, return true to avoid showing error
        if amount.isEmpty { return true }
        
        guard let value = Double(amount),
              value > 0,
              !contractService.contract.asset.name.isEmpty
        else { return false }
        return value <= contractService.contract.asset.amount
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Asset Info
                assetCard(contractService.contract.asset)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Recipient Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recipient")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text(contractService.contract.recipientAddress ?? "")
                            .kerning(0.5)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .font(.headline)
                    }
                    
                    // Amount Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Amount")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            TextField("0.0", text: $amount)
                                .keyboardType(.decimalPad)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            Text(contractService.contract.asset.symbol)
                                .font(.headline)
                                .foregroundStyle(.secondary)
                        }
                        
                        if let value = Double(amount) {
                            Text("$" + String(format: "%.2f", value * contractService.contract.asset.unitPrice))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .contentTransition(.numericText())
                                
                        }
                    }
                }
                .padding(16)
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
                
                if !isValidAmount {
                    Text("Not enough funds to cover the contract")
                        .foregroundStyle(.red)
                        .font(.subheadline)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .padding(16)
        }
        .safeAreaInset(edge: .bottom, content: {
            Button {
                if let value = Double(amount), contractService.setAmount(value) {
                    path.append(.summary)
                }
            } label: {
                Text("Next")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(isValidAmount ? .blue : .gray)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .disabled(!isValidAmount)
            .padding(16)
            .background(.background)
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Create contract")
                    .font(.headline)
            }
            
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
        .animation(.smooth, value: amount)
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
                Text(String(format: "%.2f", asset.amount))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("$" + String(format: "%.2f", asset.valueInUSD))
                .font(.headline)
        }
        .padding(12)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationStack {
        ContractDetailsEntry(path: .constant([]))
            .environmentObject(WalletService())
            .environmentObject(ContractService())
    }
    .preferredColorScheme(.dark)
}
