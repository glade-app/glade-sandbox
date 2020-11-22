//
//  Artist.swift
//  test-glade
//
//  Created by Allen Gu on 11/11/20.
//

import Foundation

public struct ArtistImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

public struct Artist: Codable {
    let id: String?
    let images: [ArtistImage]?
    let name: String?
    var users: [String]?
}

public struct ArtistResponse: Codable {
    let items: [Artist]?
}
