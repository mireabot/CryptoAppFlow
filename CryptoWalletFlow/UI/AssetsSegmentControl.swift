//
//  AssetsSegmentControl.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

enum AssetSegmentType: String, CaseIterable {
    case all = "All"
    case `public` = "Public"
    case `private` = "Private"
}

struct AssetsSegmentControl: View {
    @Binding var selection: AssetSegmentType
    let isEnabled: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AssetSegmentType.allCases, id: \.self) { type in
                Button {
                    selection = type
                } label: {
                    Text(type.rawValue)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selection == type ? Color.gray.opacity(0.3) : .clear)
                        .foregroundStyle(selection == type ? .white : .gray)
                        .clipShape(Capsule())
                }
                .animation(.smooth, value: selection)
                
            }
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(Capsule())
    }
}

#Preview {
    SegmentSampleView()
        .preferredColorScheme(.dark)
}

struct SegmentSampleView: View {
    @State var selection: AssetSegmentType = .all
    var body: some View {
        VStack {
            AssetsSegmentControl(selection: $selection, isEnabled: true)
        }
    }
}
