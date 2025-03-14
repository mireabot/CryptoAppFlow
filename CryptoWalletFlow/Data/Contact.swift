//
//  Contact.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/10/25.
//

import SwiftUI

struct Contact: Identifiable, Hashable {
    var id: String { address }
    let address: String
}
