//
//  ContentView.swift
//  TaskTracker
//
//  Created by Alex Gioffre' on 17/06/24.
//

import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID()
    let title: String
    let descrption: String
    var amount: Int
}

@Observable
class Tasks {
    var tasks = [Task]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(tasks) {
                UserDefaults.standard.set(encoded, forKey: "Tasks")
            }
        }
    }
    
    init() {
        if let savedTasks = UserDefaults.standard.data(forKey: "Tasks") {
            if let decodedTasks = try? JSONDecoder().decode([Task].self, from: savedTasks) {
                tasks = decodedTasks
                return
            }
        }
        
        tasks = []
    }
}

struct ContentView: View {
    @State private var tasks = Tasks()
    @State private var showAddTask = false
    
 
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack(alignment:.leading, spacing: 5) {
                    HStack {
                        Text("Your Activities".uppercased())
                            .foregroundColor(.white)
                        .font(.largeTitle.bold())
                        Spacer()
                        Button {
                            showAddTask = true
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .font(.title3)
                                Text("Add".uppercased())
                                    .font(.title3.bold())
                            }
                            .foregroundStyle(.blue)
                            .padding(.horizontal,10)
                            .padding(.vertical, 5)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 20))
                        }
                    }
                    List {
                        ForEach(tasks.tasks.sorted(by: {$0.amount > $1.amount })) { task in
                            NavigationLink {
                                DetailTask(tasks: tasks,task: task)
                            } label: {
                                HStack {
                                    Text(task.title)
                                    Spacer()
                                    Text(task.amount, format: .number)
                                }
                            }
                            .padding(10)
                            .background(.white)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.blue)
                            .clipShape(.rect(cornerRadius: 10))
                            .listRowSeparator(.hidden)
                        }
                        .listRowBackground(
                            Color.clear
                        )
                    }
                    .listStyle(.grouped)
                    .scrollContentBackground(.hidden)
                    .sheet(isPresented: $showAddTask){
                        AddTask(tasks: tasks)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal,20)
            }
        }
    }
}

#Preview {
    ContentView()
}
