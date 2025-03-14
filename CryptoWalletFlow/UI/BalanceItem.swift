//
//  BalanceItem.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

enum BalanceType {
    case `public`
    case `private`
    
    var title: String {
        switch self {
        case .public:
            return "Public"
        case .private:
            return "Private"
        }
    }
    
    var image: Image {
        switch self {
        case .public:
            return Image(systemName: "eye.fill")
        case .private:
            return Image(systemName: "eye.slash.fill")
        }
    }
}

struct BalanceItem: View {
    let balance: Double
    let type: BalanceType
    
    private var balanceString: String {
        String(format: "%.2f", balance)
    }
    
    private var mainAmount: String {
        if let dotIndex = balanceString.firstIndex(of: ".") {
            return String(balanceString[..<dotIndex])
        }
        return balanceString
    }
    
    private var cents: String {
        if let dotIndex = balanceString.firstIndex(of: ".") {
            return String(balanceString[dotIndex...])
        }
        return ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                type.image
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Capsule())
                
                Text(type.title.uppercased())
                    .foregroundStyle(.secondary)
            }
            .font(.footnote)
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("$" + mainAmount)
                    .foregroundStyle(.primary)
                
                Text(cents)
                    .foregroundStyle(.secondary)
            }
            .font(.largeTitle.bold())
        }
    }
}

#Preview {
    VStack {
        BalanceItem(
            balance: 256.50,
            type: .private
        )
        BalanceItem(
            balance: 2576.50,
            type: .public
        )
    }
    .padding()
    .preferredColorScheme(.dark)
}
