//
//  User.swift
//  test-glade
//
//  Created by Allen Gu on 10/24/20.
//

struct User: Codable {
    let displayName: String?
    let email: String?
    let href: String?
    let id: String?
    let images: [ProfileImage]?
    let uri: String?
    var songs: [String]?
    var artists: [String]?
    var school: String?
    var socials: [String]?


    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case email
        case href
        case id
        case images
        case uri
        case songs
        case artists
        case school
        case socials
    }
}

struct ProfileImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

