//
//  User.swift
//  test-glade
//
//  Created by Allen Gu on 10/24/20.
//

struct User: Decodable {
    let displayName: String?
    let email: String?
    let href: String?
    let id: String?
    let images: [ProfileImage]?
    let type: String?
    let uri: String?


    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case email
        case href
        case id
        case images
        case type
        case uri
    }
}

struct ProfileImage: Decodable {
    let height: Int?
    let url: String?
    let width: Int?
}

//extension User {
//    static let keychain = Keychain(service: "Allen-Gu.test-glade")
//    
//    static func saveToKeychain(user: User) {
//        if let savingData = data {
//            keychain["userData"] = User
//        }
//    }
//
//    static func loadFromKeychain() -> User? {
//        guard let user = keychain["user"] else { return nil }
//        return user
//    }}
