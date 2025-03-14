//
//  Contract.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/10/25.
//

import SwiftUI

struct Contract: Identifiable, Hashable {
    let id = UUID()
    var asset: Asset
    var amount: Double
    var senderAddress: String
    var recipientAddress: String?
    var networkFee: Double = 0.001
    var eta: String = "~15 minutes"
    
    var valueInUSD: Double {
        return amount * asset.unitPrice
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Contract, rhs: Contract) -> Bool {
        lhs.id == rhs.id
    }
}
