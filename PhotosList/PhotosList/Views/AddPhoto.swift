//
//  AddPhoto.swift
//  PhotosList
//
//  Created by Alex Gioffre' on 05/08/24.
//

import SwiftUI
import PhotosUI

struct AddPhotoView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentView.ViewModel
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var name = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("Write a title", text: $name)
                    .padding(8)
                    .font(.title2)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black)
                    }
            }
            .frame(height: 120)
            .scrollContentBackground(.hidden)
            
            PhotosPicker(selection: $pickerItem, matching: .images) {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Label("Select a picture", systemImage: "photo")
                }
            }
            .padding(10)
            
            Spacer()
            
            Button("Add") {
                if let image = selectedImage, !name.isEmpty, let imageData = image.jpegData(compressionQuality: 1.0) {
                    viewModel.add(name: name, image: imageData)
                    dismiss()
                }
            }
            .disabled(name.isEmpty || selectedImage == nil)
        }
        .onChange(of: pickerItem) {
            Task {
                if let data = try? await pickerItem?.loadTransferable(type: Data.self), let image = UIImage(data: data) {
                    selectedImage = image
                }
            }
        }
        .padding()
    }
}

#Preview {
    AddPhotoView(viewModel: ContentView.ViewModel())
}
