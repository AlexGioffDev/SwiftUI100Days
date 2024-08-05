//
//  ContentViewModel.swift
//  PhotosList
//
//  Created by Alex Gioffre' on 04/08/24.
//

import Foundation
import SwiftUI

extension ContentView {
    
    @Observable
    class ViewModel: ObservableObject{
        private(set) var photos: [PhotoItem]
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPhotos")
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                photos = try JSONDecoder().decode([PhotoItem].self, from: data)
            } catch {
                photos = []
            }
        }
        
        
        func add(name: String, image: Data) {
            guard !name.isEmpty else {return}
            if UIImage(data: image) != nil {
                let newPhoto = PhotoItem(id: UUID(), name: name, image: image)
                photos.append(newPhoto)
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(photos)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
    
}
