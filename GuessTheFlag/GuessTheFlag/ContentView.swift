//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Gioffre' on 05/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var GameOver = false
    @State private var numberQuestion = 1
    
    var formattedScore: String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 4
        formatter.maximumIntegerDigits = 4
        return formatter.string(from: NSNumber(value: score)) ?? "0000"
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ],center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTappend(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
               
                Spacer()
                Spacer()

            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: gameStatus)
        } message: {
            if scoreTitle == "Wrong" {
                Text("Wrong! This is not the flag of \(countries[correctAnswer])")
            } else {
                Text("Great!")
            }
           
        }
        .alert("Final Score", isPresented: $GameOver) {
            Button("Restart the game", action: reset)
        } message: {
            Text("Your final score is: \(formattedScore)")
        }
    }
    
    func flagTappend(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            var scores: [Int] = [20,30,40,50]
            score += scores.randomElement()!
        } else {
            scoreTitle = "Wrong"
            var scores: [Int] = [20,30,40,50]
            score -= scores.randomElement()!
            if score < 0 {
                score = 0
            }
        }
        numberQuestion += 1
        
        showingScore = true
        
    }
    
    func gameStatus() {
        if numberQuestion > 8 {
            GameOver = true
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        numberQuestion = 1
        askQuestion()
    }
}

#Preview {
    ContentView()
}
