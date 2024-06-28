//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Alex Gioffre' on 26/06/24.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
