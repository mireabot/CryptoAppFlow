//
//  WalletService.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

class WalletService: ObservableObject {
    @Published private(set) var assets: [Asset] = [
        Asset(name: "Bitcoin", symbol: "BTC", amount: 0.5, network: "Bitcoin", unitPrice: 50000, isPrivate: false),
        Asset(name: "Ethereum", symbol: "ETH", amount: 2.5, network: "Ethereum", unitPrice: 3000, isPrivate: true),
        Asset(name: "USDC", symbol: "USDC", amount: 1000, network: "Ethereum", unitPrice: 1, isPrivate: false),
        Asset(name: "Solana", symbol: "SOL", amount: 15.8, network: "Solana", unitPrice: 125, isPrivate: false),
        Asset(name: "Aleo", symbol: "ALEO", amount: 2342.5, network: "Aleo", unitPrice: 15.7, isPrivate: true),
        Asset(name: "Avalanche", symbol: "AVAX", amount: 45.3, network: "Avalanche", unitPrice: 35.8, isPrivate: false)
    ]
    
    @Published private(set) var contacts: [Contact] = [
        Contact(address: "0x1234567890abcdef1234567890abcdef12345678"),
        Contact(address: "0x7890abcdef1234567890abcdef1234567890abcd"),
        Contact(address: "0xabcdef1234567890abcdef1234567890abcdef12")
    ]
    
    var publicBalance: Double {
        assets.filter { !$0.isPrivate }.reduce(0) { $0 + $1.valueInUSD }
    }
    
    var privateBalance: Double {
        assets.filter { $0.isPrivate }.reduce(0) { $0 + $1.valueInUSD }
    }
    
    func filteredAssets(by type: AssetSegmentType) -> [Asset] {
        switch type {
        case .all:
            return assets
        case .public:
            return assets.filter { !$0.isPrivate }
        case .private:
            return assets.filter { $0.isPrivate }
        }
    }
}
