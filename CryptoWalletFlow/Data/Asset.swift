//
//  Asset.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/10/25.
//

import SwiftUI

struct Asset: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let symbol: String
    let amount: Double
    let network: String
    let unitPrice: Double
    let isPrivate: Bool
    
    var valueInUSD: Double {
        return amount * unitPrice
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        lhs.id == rhs.id
    }
}
