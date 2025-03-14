//
//  ContractService.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

enum ContractStep {
    case selectRecipient
    case selectAsset
    case enterAmount
    case summary
}

class ContractService: ObservableObject {
    @Published private(set) var contract: Contract
    @Published var currentStep: ContractStep = .selectRecipient
    
    init() {
        // Initialize with default empty contract using full address
        self.contract = Contract(
            asset: Asset(name: "", symbol: "", amount: 0, network: "", unitPrice: 0, isPrivate: false),
            amount: 0,
            senderAddress: "0x1234567890abcdef1234567890abcdef12345678"
        )
    }
    
    func setRecipient(_ contact: Contact) {
        contract.recipientAddress = contact.address
    }
    
    func setAsset(_ asset: Asset) {
        contract.asset = asset
    }
    
    func setAmount(_ amount: Double) -> Bool {
        // Validate if amount is not greater than available balance
        guard amount <= contract.asset.amount else {
            return false
        }
        
        contract.amount = amount
        return true
    }
    
    func submitContract() {
        // Here you would implement the actual contract submission
        // For now, we'll just reset the contract
        contract = Contract(
            asset: Asset(name: "", symbol: "", amount: 0, network: "", unitPrice: 0, isPrivate: false),
            amount: 0,
            senderAddress: "0x1234567890abcdef1234567890abcdef12345678"
        )
        currentStep = .selectRecipient
    }
    
    func moveToNextStep() {
        switch currentStep {
        case .selectRecipient:
            currentStep = .selectAsset
        case .selectAsset:
            currentStep = .enterAmount
        case .enterAmount:
            currentStep = .summary
        case .summary:
            break
        }
    }
}
