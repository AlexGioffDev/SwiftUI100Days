//
//  PhotoDetail.swift
//  PhotosList
//
//  Created by Alex Gioffre' on 05/08/24.
//

import SwiftUI

struct PhotoDetail: View {
    
    var photoItem: PhotoItem
    
    var body: some View {
        if let image = UIImage(data: photoItem.image) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .navigationTitle(photoItem.name)
                .navigationBarTitleDisplayMode(.inline)
        }    }
}

#Preview {
    PhotoDetail(photoItem: PhotoItem(id: UUID(), name: "Sample", image: Data()))
}
