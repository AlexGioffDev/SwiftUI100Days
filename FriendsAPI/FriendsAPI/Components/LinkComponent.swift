//
//  LinkComponent.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 01/07/24.
//

import SwiftUI

struct LinkComponent: View {
    
    var name: String
    var isActive: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundStyle(.black)
            Spacer()
            HStack {
                ActiveCircle(isActive: isActive)
                Text(">")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
           
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(.white)
        .clipShape(Capsule())
    }
}

#Preview {
    LinkComponent(name: "Alex", isActive: true)
}
