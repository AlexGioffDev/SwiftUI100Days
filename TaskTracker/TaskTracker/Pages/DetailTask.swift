//
//  DetailTask.swift
//  TaskTracker
//
//  Created by Alex Gioffre' on 17/06/24.
//

import SwiftUI

struct DetailTask: View {
    
    var tasks: Tasks
    
    var task: Task
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    Text(task.title.uppercased())
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.heavy))
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.white)
                        .padding(.vertical, 2)
                    
                    Text("Description")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(task.descrption)
                                .font(.title3.weight(.light))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }  
                    .frame(maxHeight: 300)

                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                    
                    HStack(spacing: 20) {
                        Text(task.amount, format: .number)
                            .font(.title.bold())
                            .foregroundStyle(.blue)
                        Spacer()
                        Button {
                            if let index = tasks.tasks.firstIndex(where: {$0.id == task.id}) {
                                tasks.tasks[index].amount += 1
                            }
                        }label: {
                            Image(systemName: "plus")
                                .font(.title.bold())
                                .imageScale(.medium)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.blue)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal, 20)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    Spacer()
                }
                .padding(20)
            }
        }
        
    }
}

#Preview {
    DetailTask(tasks: Tasks(),task: Task(title: "Coding", descrption: "Today i coding with SwiftUI", amount: 1))
}
