//
//  User.swift
//  test-glade
//
//  Created by Allen Gu on 10/24/20.
//

struct User: Decodable {
    var displayName: String?
    var email: String?
    var href: String?
    var id: String?
    var images: [ProfileImage]?
    var type: String?
    var uri: String?


    
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
    var height: String?
    var url: String?
    var width: String?
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
