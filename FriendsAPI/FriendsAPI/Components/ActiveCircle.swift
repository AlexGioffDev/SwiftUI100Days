//
//  ActiveCircle.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 01/07/24.
//

import SwiftUI

struct Pulsing: ViewModifier {
    var isActive: Bool
    @State private var animationAmount: Double = 1.0
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .overlay(
                    Circle()
                        .stroke(.green)
                        .scaleEffect(animationAmount)
                        .opacity(1.5 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animationAmount
                        )
                )
                .onAppear {
                    animationAmount = 1.5
                }
        } else {
            content
        }
    }
}


struct ActiveCircle: View {
    var isActive: Bool
    var body: some View {
        Circle()
            .fill(isActive ? .green : .gray)
            .frame(width: 20)
            .modifier(Pulsing(isActive: isActive))
            
    }
}

#Preview {
    ActiveCircle(isActive: true)
}
