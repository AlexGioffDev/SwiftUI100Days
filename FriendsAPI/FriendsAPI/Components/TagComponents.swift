//
//  TagComponents.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 02/07/24.
//

import SwiftUI

struct TagComponents: View {
    
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.callout)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        }
        .padding(10)
       
    }
}

#Preview {
    TagComponents(text: "Hello")
}
