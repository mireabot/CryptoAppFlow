//
//  CryptoWalletFlowApp.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/9/25.
//

import SwiftUI

@main
struct CryptoWalletFlowApp: App {
    let walletService = WalletService()
    let swapService: SwapService
    
    init() {
        self.swapService = SwapService(walletService: walletService)
    }
    
    var body: some Scene {
        WindowGroup {
            WalletDashboard()
                .environmentObject(walletService)
                .environmentObject(swapService)
                .preferredColorScheme(.dark)
        }
    }
}
