//
//  ContentView.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 30/06/24.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    
    
    @State private var path = NavigationPath()
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 8) {
                Text("Users List")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                List(users, id: \.id) {user in
                    Button {
                        path.append(user)
                    } label: {
                        LinkComponent(name: user.name, isActive: user.isActive)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .navigationDestination(for: User.self){ user in
                    UserDetailView(user: user)
                    
                }
                .scrollContentBackground(.hidden)
                .padding(.bottom, 9)
                .task {
                    if users.isEmpty {
                        await loadUserData()
                    }
                    
                }
            }
            .padding(20)
            .background(LinearGradient(colors: [.cyan, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }
    
    func loadUserData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try decoder.decode([User].self, from: data)
            for user in decodedData {
                modelContext.insert(user)
            }
        } catch {
            print("Invalid Data")
        }
        
    }
}

#Preview {
    ContentView()
}
