//
//  PhotoItem.swift
//  PhotosList
//
//  Created by Alex Gioffre' on 01/08/24.
//

import Foundation


struct PhotoItem: Identifiable, Codable, Comparable {
    let id: UUID
    var name: String
    var image: Data
    
    static func <(lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.name < rhs.name
    }
}
