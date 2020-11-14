//
//  Song.swift
//  test-glade
//
//  Created by Allen Gu on 11/11/20.
//

import Foundation

struct Album: Codable {
    let images: [AlbumImage]?
}

struct Song: Codable {
    let album: Album?
    let name: String?
    let artists: [Artist]?
    let id: String?
}

struct AlbumImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct SongResponse: Codable {
    let items: [Song]?
}
