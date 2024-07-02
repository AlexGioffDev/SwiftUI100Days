//
//  ContentView.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 30/06/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var users = [User]()
    @State private var path = NavigationPath()
    
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
                    await loadUserData()
                    
                    
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
        
        guard users.isEmpty else { return }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try decoder.decode([User].self, from: data)
            users = decodedData
        } catch {
            print("Invalid Data")
        }
        
    }
}

#Preview {
    ContentView()
}
