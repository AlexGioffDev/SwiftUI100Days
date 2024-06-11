import SwiftUI

struct Question {
    let question: String
    let answer: Int
    let options: [Int]
}

struct Answer {
    let question: String
    let answer: Int
    let correct: Bool
}

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @State private var gameStarter = false
    @State private var gameEndend = false
    
    @State private var number = 2
    @State private var num_questions = [5, 10, 20]
    @State private var num_question = 5
    
    @State private var questions: [Question] = []
    @State private var currentIndex = 0
    @State private var results: [Answer] = []
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    if !gameStarter {
                        VStack(alignment: .leading, spacing: 10) {
                            Stepper("Number: \(number.formatted(.number))", value: $number, in: 2...12)
                                .foregroundStyle(.white)
                                .font(.title2.weight(.semibold))
                                .padding(10)
                                .background(.purple.gradient)
                                .clipShape(.rect(cornerRadius: 10))
                            Section{
                                Text("Questions:")
                                    .foregroundStyle(.white)
                                    .font(.title2.weight(.regular))
                                Picker("", selection: $num_question) {
                                    ForEach(num_questions, id: \.self) {
                                        Text($0.formatted(.number))
                                    }
                                }.pickerStyle(.segmented)
                                    .colorMultiply(.purple)
                            }
                        }
                        Spacer()
                        Button {
                            withAnimation {
                                startGame()
                                gameStarter = true
                            }
                        } label: {
                            HStack(spacing: 20) {
                                Image(systemName: "play.fill")
                                    .imageScale(.large)
                                    .foregroundStyle(.white)
                                    .font(.headline.weight(.semibold))
                                Text("Play")
                                    .foregroundStyle(.white)
                                    .font(.title.weight(.bold))
                            }
                        }
                        .frame(width: 200, height: 100)
                        .background(.purple.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer()
                    } else if (gameStarter && questions.count > 0) && !gameEndend {
                        VStack(spacing: 30) {
                            Text(questions[currentIndex].question)
                                .foregroundStyle(.white)
                                .font(.title.weight(.bold))
                            Spacer()
                            Spacer()
                            VStack(spacing: 40) {
                                HStack(spacing: 20) {
                                    ForEach(0..<2){ index in
                                        Button {
                                            let correctAnswer = checkAnswer(answer: questions[currentIndex].options[index], index: currentIndex)
                                            let answer = Answer(question: questions[currentIndex].question, answer: questions[currentIndex].answer, correct: correctAnswer)
                                            results.append(answer)
                                            currentIndex += 1
                                            
                                            if currentIndex > questions.count - 1 {
                                                gameEndend = true
                                            }
                                        } label: {
                                            Text(questions[currentIndex].options[index].formatted(.number))
                                                .frame(width: 100, height: 80)
                                                .foregroundStyle(.white)
                                                .font(.title2.weight(.bold))
                                                .background(.purple.gradient)
                                                .clipShape(.rect(cornerRadius: 20))

                                        }
                                    }
                                }
                                HStack(alignment: .center,spacing: 20) {
                                    ForEach(2..<4){ index in
                                        Button {
                                            let correctAnswer = checkAnswer(answer: questions[currentIndex].options[index], index: currentIndex)
                                            let answer = Answer(question: questions[currentIndex].question, answer: questions[currentIndex].answer, correct: correctAnswer)
                                            results.append(answer)
                                            currentIndex += 1
                                            
                                            if currentIndex > questions.count - 1 {
                                                gameEndend = true

                                            }
                                        } label: {
                                            Text(questions[currentIndex].options[index].formatted(.number))
                                                .frame(width: 100, height: 80)
                                                .foregroundStyle(.white)
                                                .font(.title2.weight(.bold))
                                                .background(.purple.gradient)
                                                .clipShape(.rect(cornerRadius: 20))
                                        }
                                    }
                                }
                            Spacer()
                            }

                        }
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        .padding(.vertical, 10)
                    } else {
                        VStack {
                            List {
                                ForEach(results, id: \.question) { result in
                                    HStack(spacing: 0) {
                                        Text(result.question)
                                            .foregroundStyle(.white)
                                            .font(.headline.weight(.semibold))
                                        Spacer()
                                        Text(result.answer.formatted(.number))
                                            .foregroundStyle(.white)
                                            .font(.headline.weight(.semibold))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(20)
                                    .background(result.correct ? .green : .red)
                                    .clipShape(.rect(cornerRadius: 20))
                                }
                                .listRowBackground(
                                    Color.clear
                                )
                            }
                            .listStyle(.grouped)
                            .padding(10)
                            .scrollContentBackground(.hidden)
                            Spacer()
                            Button {
                              gameEndend = false
                            gameStarter = false
                            } label: {
                                HStack {
                                    HStack(spacing: 20) {
                                        Image(systemName: "play.fill")
                                            .imageScale(.large)
                                            .foregroundStyle(.white)
                                            .font(.headline.weight(.semibold))
                                        Text("Play")
                                            .foregroundStyle(.white)
                                            .font(.title.weight(.bold))
                                    }
                                }
                                .frame(width: 200, height: 100)
                                .background(.purple.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                }
                .padding(30)
            }
            .navigationTitle("MathForKids")
        }
    }
    
    func startGame() {
        questions.removeAll()
        for _ in 1...num_question {
            let randomValue = Int.random(in: 2...12)
            let result = number * randomValue
            let text = "What is the \(number) x \(randomValue) result?"
            let newQuestion = Question(question: text, answer: result, options: generateAnswers(answer: result))
            questions.append(newQuestion)
        }
        currentIndex = 0
    }
    
    func generateAnswers(answer: Int) -> [Int]{
        var options = Set([answer])
        while options.count < 4 {
            options.insert(Int.random(in: 2...(number * 12)))
        }
        return Array(options).shuffled()
    }
    
    func checkAnswer(answer: Int, index: Int) -> Bool {
        if questions[index].answer == answer {
            return true
        }
        return false
    }
}

#Preview {
    ContentView()
}

