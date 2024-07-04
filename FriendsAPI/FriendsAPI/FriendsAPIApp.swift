//
//  FriendsAPIApp.swift
//  FriendsAPI
//
//  Created by Alex Gioffre' on 30/06/24.
//

import SwiftData
import SwiftUI

@main
struct FriendsAPIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
