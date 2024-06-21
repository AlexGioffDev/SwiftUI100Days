//
//  AddTask.swift
//  TaskTracker
//
//  Created by Alex Gioffre' on 17/06/24.
//

import SwiftUI

struct AddTask: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    
    
    var tasks: Tasks
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                LinearGradient(colors: [.cyan, .blue], startPoint: .topTrailing, endPoint: .bottomLeading).ignoresSafeArea()
                VStack(spacing:10) {
                    Spacer()
                    Text("Create a New Task".uppercased())
                        .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(.white)
                    Spacer()
                    Form {
                        Section {
                            TextField("Title", text:$title)
                        } header: {
                             Text("Title")
                                .font(.headline.weight(.light))
                                .foregroundStyle(.white)
                        }
                        .listRowSeparator(.hidden)
                        Section {
                            TextEditor(text: $description)
                        } header: {
                                 Text("Description")
                                    .font(.headline.weight(.light))
                                    .foregroundStyle(.white)
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .frame(height: 350)
                    Button {
                        if (title == "") || (description == ""){
                            return
                        }
                        let newTask = Task(title: title, descrption: description, amount: 1)
                        tasks.tasks.append(newTask)
                        dismiss()
                    } label: {
                        HStack(spacing: 30) {
                            Image(systemName: "paperplane")
                                .imageScale(.large)
                                .font(.title2)
                            Text("Create")
                                .font(.title2.bold())
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical,10)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(color: .white,radius: 5)
                    }
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    AddTask(tasks: Tasks())
}
