//
//  ContentView.swift
//  WinOrLose
//
//  Created by Alex Gioffre' on 07/06/24.
//

//Each turn of the game the app will randomly pick either rock, paper, or scissors.
//Each turn the app will alternate between prompting the player to win or lose.
//The player must then tap the correct move to win or lose the game.
//If they are correct they score a point; otherwise they lose a point.
//The game ends after 10 questions, at which point their score is shown.

import SwiftUI

struct TextTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .font(.title2.weight(.semibold))
    }
}

struct BigTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .foregroundStyle(.indigo)
            .font(.largeTitle.weight(.bold))
    }
}


struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.indigo)
            .font(.title2.weight(.semibold))
            .padding(20)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(color: .purple,radius: 10)
    }
}


struct Testo: View {
    var text: String
    var bigTitle: Bool = false
    
    var body: some View {
        if bigTitle {
            Text(text)
                .modifier(BigTitle())
        } else {
           Text(text)
                .modifier(TextTitle())
        }
    }
}



struct ContentView: View {
    
    var choices = ["Rock", "Paper", "Scissors"]
    @State private var pcChoiceMove = ["Rock", "Paper", "Scissors"].randomElement() ?? "Paper"
    @State private var pcChoice = ["Lose", "Win"].randomElement() ?? "Lose"
    
    @State private var yourMove = "Paper"
    
    @State private var score = 0
    @State private var round = 1
    
    @State private var gameOver = false
    
    func checkGame() {
        var youWin = false
        
        switch(pcChoiceMove, pcChoice) {
        case ("Rock", "Win"):
            youWin = yourMove == "Paper"
        case ("Rock", "Lose"):
            youWin = yourMove == "Scissors"
        case ("Paper", "Win"):
            youWin = yourMove == "Scissors"
        case ("Paper", "Lose"):
            youWin = yourMove == "Rock"
        case ("Scissors", "Win"):
            youWin = yourMove == "Rock"
        case ("Scissors", "Lose"):
            youWin = yourMove == "Paper"
        default:
            youWin = false
        }
        
        if youWin {
            score += 1
        } else {
            score -= 1
            if score < 0 {
                score = 0
            }
        }
        
        round += 1
        if(round > 10){
            gameOver = true
        } else {
            newGame()
        }
    }
    
    func newGame() {
        pcChoiceMove = ["Rock", "Paper", "Scissors"].randomElement() ?? "Paper"
        pcChoice = ["Lose", "Win"].randomElement() ?? "Lose"
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack( spacing: 40) {
                Text("Rock Paper and Listen!".uppercased())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.bold))
                    .padding(.horizontal, 10)
                HStack(alignment:.center, spacing: 20) {
                    VStack {
                        Testo(text: "PC Move")
                        Testo(text: pcChoiceMove, bigTitle: true)
                    }
                    VStack {
                        Testo(text: "You must")
                        Testo(text: pcChoice, bigTitle: true)
                    }
                }
                .padding(40)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                HStack(spacing: 20) {
                    Button {
                        yourMove = "Rock"
                        checkGame()
                    } label: {
                        Text("Rock")
                            .modifier(ButtonText())
                    }
                    Button {
                        yourMove = "Paper"
                        checkGame()
                    } label: {
                        Text("Paper")
                            .modifier(ButtonText())
                    }
                    Button {
                        yourMove = "Scissors"
                        checkGame()
                    } label: {
                        Text("Scissors")
                            .modifier(ButtonText())
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 150)
        }
        .alert("GameOver!", isPresented: $gameOver) {
            Button("Play Again!") {
                score = 0
                round = 1
                newGame()
            }
        } message: {
            Text("Your score is \(score)")
        }
        
    }
}

#Preview {
    ContentView()
}
