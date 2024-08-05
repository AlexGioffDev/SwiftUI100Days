//
//  ContentView.swift
//  PhotosList
//
//  Created by Alex Gioffre' on 01/08/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    
    
    @State private var viewModel = ViewModel()
    @State private var showAdd = false
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("List Photos".uppercased())
                    .font(.title.bold())
                    .padding(.top, 20)
                Spacer()
                if(viewModel.photos.isEmpty) {
                    EmptyView()
                } else {
                    List(viewModel.photos) { data in
                        ZStack {
                            NavigationLink(destination: PhotoDetail(photoItem: data)){}.opacity(0)
                            HStack {
                                if let image = UIImage(data: data.image) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color.black, lineWidth: 1)
                                        )
                                        .padding(.trailing, 10)
                                }
                                Spacer()
                                HStack {
                                    Text(data.name)
                                        .font(.title3)
                                    Text(">")
                                        .font(.callout)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black)
                            }
                        }
                        
                        
                    }
                    .scrollContentBackground(.hidden)
                }
                Spacer()
            }
            .toolbar {
                Button("Add") {
                    showAdd = true
                }
            }
            .sheet(isPresented: $showAdd){
                AddPhotoView(viewModel: viewModel)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
