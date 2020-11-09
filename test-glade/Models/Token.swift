//
//  Account.swift
//  test-glade
//
//  Created by Allen Gu on 11/8/20.
//

import Foundation
import Security

enum TokenError: Error {
    case failedConversion
    case didNotSetToken
    case didNotGetToken
    case didNotUpdateToken
    case tokenNotFound
}

extension TokenError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedConversion:
            return NSLocalizedString("Failed to convert token to Data", comment: "")
        case .didNotSetToken:
            return NSLocalizedString("Could not set token in Keychain", comment: "")
        case .didNotGetToken:
            return NSLocalizedString("Could not get token from Keychain", comment: "")
        case .didNotUpdateToken:
            return NSLocalizedString("Could not update token from Keychain", comment: "")
        case .tokenNotFound:
            return NSLocalizedString("Could not find token", comment: "")
        }
    }
}

struct Token {
    static func setToken(_ token: String, _ tokenType: String) throws {
        print("Setting token - \(tokenType):", token)
//        let tag = "Allen-Gu.test-glade".data(using: .utf8)!
        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrLabel as String: tokenType]
        let encodedToken = token.data(using: .utf8)
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            let tokenToUpdate: [String: Any] = [kSecValueData as String: encodedToken]
            status = SecItemUpdate(query as CFDictionary, tokenToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw TokenError.didNotUpdateToken
            }
            print("Finished updating token - \(tokenType)")
        case errSecItemNotFound:
            query[kSecValueData as String] = encodedToken
            SecItemAdd(query as CFDictionary, nil)
            print("Finished setting token - \(tokenType)")
        default:
            print("Unable to set token - \(tokenType)")
            throw TokenError.didNotSetToken
        }
    }
    
    static func getToken(_ tokenType: String) throws -> String {
        let getquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrLabel as String: tokenType,
                                       kSecMatchLimit as String: kSecMatchLimitOne,
                                       kSecReturnAttributes as String: true,
                                       kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getquery as CFDictionary, &item)
        print("Finished getting token - \(tokenType) - with status: \(status)")
        guard status == errSecSuccess else {
            throw TokenError.tokenNotFound
        }
        
        guard let existingItem = item as? [String : Any],
            let tokenData = existingItem[kSecValueData as String] as? Data,
            let token = String(data: tokenData, encoding: .utf8)
        else {
            throw TokenError.didNotGetToken
        }
        return token
    }
    
    // Need code to refresh token
}
