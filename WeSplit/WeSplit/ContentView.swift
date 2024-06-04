//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Gioffre' on 02/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var peoples = 2
    @FocusState private var focused: Bool
    
    var totalPerson: Double {
        // Calculate
        let peopleCount = Double(peoples + 2)
        return checkAmount / peopleCount
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR")).keyboardType(.decimalPad).focused($focused)
                    Picker("Number of people", selection: $peoples) {
                        ForEach(2..<11){
                            Text("\($0) peoples")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section{
                    Text(totalPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if focused {
                    Button("Done") {
                        focused = false
                    }
                }
            }
            
           
        }

    }
}

#Preview {
    ContentView()
}
