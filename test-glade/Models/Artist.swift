//
//  Artist.swift
//  test-glade
//
//  Created by Allen Gu on 11/11/20.
//

import Foundation

struct Artist: Codable {
    let id: String?
    let images: [ArtistImage]?
    let name: String?
    
}

struct ArtistImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct ArtistResponse: Codable {
    let items: [Artist]?
}
