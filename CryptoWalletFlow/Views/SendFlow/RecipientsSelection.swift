//
//  RecipientsSelection.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct RecipientsSelection: View {
    @EnvironmentObject private var walletService: WalletService
    @EnvironmentObject private var contractService: ContractService
    @Environment(\.dismiss) private var dismiss
    @Binding var path: [SendFlowScreen]

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(walletService.contacts) { contact in
                    Button {
                        contractService.setRecipient(contact)
                        path.append(.assets)
                    } label: {
                        Text(contact.address)
                            .kerning(0.5)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .foregroundStyle(.white)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select recipient")
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
}

#Preview {
    NavigationStack {
        RecipientsSelection(path: .constant([]))
            .environmentObject(WalletService())
            .environmentObject(ContractService())
    }
    .preferredColorScheme(.dark)
}
