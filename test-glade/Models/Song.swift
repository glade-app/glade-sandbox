//
//  Song.swift
//  test-glade
//
//  Created by Allen Gu on 11/11/20.
//

import Foundation

struct Album: Decodable {
    let images: [AlbumImage]?
}
struct Song: Decodable {
    let album: Album?
    let name: String?
    let artists: [Artist]?
    let id: String?

}

struct AlbumImage: Decodable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct SongResponse: Decodable {
    let items: [Song]?
}
