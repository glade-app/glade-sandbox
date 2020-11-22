//
//  Song.swift
//  test-glade
//
//  Created by Allen Gu on 11/11/20.
//

import Foundation

public struct Album: Codable {
    let images: [AlbumImage]?
}

public struct AlbumImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

public struct Song: Codable {
    let album: Album?
    let name: String?
    let artists: [Artist]?
    let id: String?
    var users: [String]?
}

public struct SongResponse: Codable {
    let items: [Song]?
}
