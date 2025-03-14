//
//  CryptoWalletFlowApp.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/9/25.
//

import SwiftUI

@main
struct CryptoWalletFlowApp: App {
    var body: some Scene {
        WindowGroup {
            WalletDashboard()
                .preferredColorScheme(.dark)
        }
    }
}
