//
//  SwapService.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/19/25.
//

import Foundation

@MainActor
class SwapService: ObservableObject {
    @Published var initialAsset: Asset?
    @Published var targetAsset: Asset?
    @Published var initialAmount: String = ""
    @Published var targetAmount: String = ""
    
    private let walletService: WalletService
    
    init(walletService: WalletService) {
        self.walletService = walletService
        self.initialAsset = walletService.assets.first
    }
    
    var currentInitialAsset: Asset {
        initialAsset ?? walletService.assets.first!
    }
    
    var currentTargetAsset: Asset {
        targetAsset ?? walletService.assets.first!
    }
    
    func swapAssets() {
        let tempAsset = initialAsset
        let tempAmount = initialAmount
        
        initialAsset = targetAsset
        initialAmount = targetAmount
        
        targetAsset = tempAsset
        targetAmount = tempAmount
        
        calculateSwap()
    }
    
    func calculateSwap() {
        guard let amount = Double(initialAmount) else { return }
        
        // Simulated conversion rate based on USD values
        let initialValueInUSD = amount * currentInitialAsset.valueInUSD
        let targetRate = currentTargetAsset.valueInUSD
        
        let convertedAmount = initialValueInUSD / targetRate
        print("Converting \(amount) \(currentInitialAsset.name) to \(convertedAmount) \(currentTargetAsset.name)")
        targetAmount = String(format: "%.2f", convertedAmount)
    }
}
