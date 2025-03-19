//
//  SwapEntry.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/19/25.
//

import SwiftUI

struct SwapFlowView: View {
    @EnvironmentObject private var swapService: SwapService
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    enum Field {
        case initial, target
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    SwapTextFieldRow(
                        value: $swapService.initialAmount,
                        asset: swapService.currentInitialAsset,
                        isEnabled: false
                    ) { asset in
                        swapService.initialAsset = asset
                        swapService.calculateSwap()
                    }
                    
                    ZStack {
                        Divider()
                        
                        Button {
                            withAnimation(.smooth) {
                                swapService.swapAssets()
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(.black)
                                .clipShape(Circle())
                        }
                    }
                    
                    SwapTextFieldRow(
                        value: $swapService.targetAmount,
                        asset: swapService.currentTargetAsset,
                        isEnabled: false
                    ) { asset in
                        swapService.targetAsset = asset
                        swapService.calculateSwap()
                    }
                }
                .padding()
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                })
                .padding()
                
                Spacer()
                
                VStack(spacing: 16) {
                    NumericKeyboard(
                        textValue: $swapService.initialAmount,
                        submitAction: {
                            print("Done")
                            swapService.calculateSwap()
                        }
                    )
                    
                    Button(action: {}, label: {
                        Text("Preview Swap")
                            .font(.system(.headline, weight: .medium))
                            .padding(10)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
            }
            .background(.black)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Swap Assets")
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
            .onChange(of: swapService.initialAmount) { _, _ in
                swapService.calculateSwap()
            }
        }
    }
}

#Preview {
    let walletService = WalletService()
    let swapService = SwapService(walletService: walletService)
    
    return SwapFlowView()
        .environmentObject(walletService)
        .environmentObject(swapService)
        .preferredColorScheme(.dark)
}
