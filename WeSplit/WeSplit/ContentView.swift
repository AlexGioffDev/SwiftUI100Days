//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Gioffre' on 02/06/24.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Select A student: \(selectedStudent)")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

#Preview {
    ContentView()
}
