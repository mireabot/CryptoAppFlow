//
//  HoldToSendButton.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/14/25.
//

import SwiftUI

struct HoldToSendButton: View {
    let onComplete: () -> Void
    
    @State private var progress: CGFloat = 0
    @State private var isCompleted = false
    @State private var isHolding = false
    
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
            Text("HOLD TO SEND")
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.white)
        .foregroundStyle(.black)
        .clipShape(Capsule())
        .overlay {
            Capsule()
                .trim(from: 0, to: progress)
                .stroke(
                    .linearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 3
                )
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isCompleted && !isHolding {
                        isHolding = true
                        withAnimation(.linear(duration: 2)) {
                            progress = 1
                        }
                        
                        // Add delay to check completion
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            if isHolding && progress >= 1 {
                                isCompleted = true
                                onComplete()
                            }
                        }
                    }
                }
                .onEnded { _ in
                    isHolding = false
                    if !isCompleted {
                        withAnimation(.smooth) {
                            progress = 0
                        }
                    }
                }
        )
    }
}

#Preview {
    HoldToSendButton {
        print("Send completed!!")
    }
        .padding()
        .preferredColorScheme(.dark)
}
