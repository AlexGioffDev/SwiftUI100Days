//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Alex Gioffre' on 04/06/24.
//

import SwiftUI

struct ContentView: View {
    var enterUnit = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var outUnit = ["Celcius", "Fahrenheit", "Kelvin"]
    
    @State private var temperatureIn = 0.0
    
    @State private var selectedEnterUnit = "Celsius"
    @State private var selectedOutUnit = "Fahrenheit"
    
    var outTemperature: Double {

        let tempInCelsius: Double
                
        // Si converte se necessario la temperature in entrata in celcius
        switch selectedEnterUnit {
            case "Fahrenheit":
                tempInCelsius = (temperatureIn - 32) * 5 / 9
            case "Kelvin":
                tempInCelsius = temperatureIn - 273.15
            default:
                tempInCelsius = temperatureIn
        }
                
        // Si ritorna il valore in base l'unità scelta
        switch selectedOutUnit {
            case "Fahrenheit":
                return tempInCelsius * 9 / 5 + 32
            case "Kelvin":
                return tempInCelsius + 273.15
            default:
                return tempInCelsius
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature in: \(selectedEnterUnit)") {
                    TextField("Temperature: ", value: $temperatureIn, format: .number).keyboardType(.decimalPad)
                }
                
                Section("Choise your unit!") {
                    Picker("In Temperature", selection: $selectedEnterUnit){
                        ForEach(enterUnit, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    Picker("Out Temperature", selection: $selectedOutUnit){
                        ForEach(outUnit, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section{
                    EmptyView()
                }
                
                Section("Temperature in: \(selectedOutUnit)") {
                    Text(outTemperature, format: .number)
                }
            }
            .navigationTitle("TemperatureConverter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
