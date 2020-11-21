//
//  DataStorage.swift
//  test-glade
//
//  Created by Allen Gu on 11/13/20.
//

import Foundation
import Alamofire
import Firebase
import FirebaseFirestore
import CodableFirebase
// https://github.com/alickbass/CodableFirebase

class DataStorage {
    static func storeUserData(user: User, completion: @escaping (_ result: Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username!)
        let schoolReference = db.collection("schools").document(school!)
        let data = try! FirestoreEncoder().encode(user)
        userReference.getDocument { (document, error) in
            if let document = document {
                // If user does not already exist in the database
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: userReference)
                    batch.updateData([
                        "artists": [],
                        "songs": []
                    ], forDocument: userReference)
                    batch.updateData([
                                        "users": FieldValue.arrayUnion([username!]),
                                        "user_count": FieldValue.increment(Int64(1)),
                    ], forDocument: schoolReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error writing user data", error)
                        }
                        else {
                            completion(true)
                        }
                    }
                }
                else {
                    let batch = db.batch()
                    batch.updateData(data, forDocument: userReference)
                    batch.updateData(["users": FieldValue.arrayUnion([username!])], forDocument: schoolReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error writing user data", error)
                        }
                        else {
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
    static func ifUserExists(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let username = UserDefaults.standard.string(forKey: "username")
        let userReference = db.collection("users").document(username!)
                
        userReference.getDocument { (document, error) in
            if let document = document {
                if document.exists {
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
        }
    }

    static func updateUserFieldValue(field: String, value: Any) {
        let username = UserDefaults.standard.string(forKey: "username")
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username!)
        
        userReference.updateData([
            field: value
        ]) { error in
            if let error = error {
                print("Failed to write \(field) to user's database", error)
            } else {
                print("Successfully wrote \(field) to user's database")
            }
        }
    }
    
    static func getUserTopArtists(accessToken: String, completion: @escaping (_ result: Bool, _ artists: [Artist]) -> ()) {
        var artists: [Artist] = []

        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: accessToken)]
        let parameters: Parameters = ["time_range": "short_term", "limit": 50]
        let request = AF.request("https://api.spotify.com/v1/me/top/artists", parameters: parameters, headers: headers)
        
        request.responseDecodable(of: ArtistResponse.self) { (response) in
            if let artistResponse = response.value {
                for artist in artistResponse.items! {
                    artists.append(artist)
                }
                completion(true, artists)
            }
            else {
                print("Failed to decode artists")
                completion(false, [])
            }
        }
    }
    
    static func getUserTopSongs(accessToken: String, completion: @escaping (_ result: Bool, _ songs: [Song]) -> ()) {
        var songs: [Song] = []

        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: accessToken)]
        let parameters: Parameters = ["time_range": "short_term", "limit": 50]
        let request = AF.request("https://api.spotify.com/v1/me/top/tracks", parameters: parameters, headers: headers)
        
        request.responseDecodable(of: SongResponse.self) { (response) in
            if let songResponse = response.value {
                for song in songResponse.items! {
                    songs.append(song)
                }
                completion(true, songs)
            }
            else {
                print("Failed to decode songs")
                completion(false, [])
            }
        }
    }
    
    static func storeArtist(artist: Artist, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let data = try! FirestoreEncoder().encode(artist)
        
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        let userReference = db.collection("users").document(username!)
        let artistReference = db.collection("schools").document(school!).collection("artists").document(artist.id!)

        // Try requesting the artist's document from Firestore
        artistReference.getDocument { (document, error) in
            if let document = document {
                // If the artist's document doesn't exist
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: artistReference)
                    batch.updateData([
                                        "user_count": 1,
                                        "users": FieldValue.arrayUnion([username!])
                    ], forDocument: artistReference)
                    batch.updateData(["artists": FieldValue.arrayUnion([artist.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error writing artist data - \(artist.id!)", error)
                        }
                        else {
                            print("Success writing artist data - \(artist.id!)")
                            completion(true)
                        }
                    }
                }
                else {
                    let batch = db.batch()
                    batch.updateData([
                                        "users": FieldValue.arrayUnion([username!]),
                                        "user_count": FieldValue.increment(Int64(1)),
                    ], forDocument: artistReference)
                    batch.updateData(["artists": FieldValue.arrayUnion([artist.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error updating artist data - \(artist.id!)", error)
                        }
                        else {
                            print("Success updating artist data - \(artist.id!)")
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
    static func storeSong(song: Song, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let data = try! FirestoreEncoder().encode(song)
        
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        let userReference = db.collection("users").document(username!)
        let songReference = db.collection("schools").document(school!).collection("songs").document(song.id!)

        // Try requesting the song's document from Firestore
        songReference.getDocument { (document, error) in
            if let document = document {
                // If the song's document doesn't exist, first set the document data
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: songReference)
                    batch.updateData([
                                        "user_count": 1,
                                        "users": FieldValue.arrayUnion([username!]),
                    ], forDocument: songReference)
                    batch.updateData(["songs": FieldValue.arrayUnion([song.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error writing song data - \(song.id!)", error)
                        }
                        else {
                            print("Success writing song data - \(song.id!)")
                            completion(true)
                        }
                    }
                }
                // Else if song's document does exist, update data rather than set it
                else {
                    let batch = db.batch()
                    batch.updateData([
                                        "users": FieldValue.arrayUnion([username!]),
                                        "user_count": FieldValue.increment(Int64(1))
                    ], forDocument: songReference)
                    batch.updateData(["songs": FieldValue.arrayUnion([song.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error updating song data - \(song.id!)", error)
                        }
                        else {
                            print("Success updating song data - \(song.id!)")
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
    static func removeUserPreviousArtists(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        
        let username = UserDefaults.standard.string(forKey: "username")
        let userReference = db.collection("users").document(username!)
        let school = UserDefaults.standard.string(forKey: "school")
        
        db.runTransaction({ (transaction, errorPointer) -> Any?  in
            let userDocument: DocumentSnapshot
            do {
                try userDocument = transaction.getDocument(userReference)
            } catch let error as NSError {
                errorPointer?.pointee = error
                return nil
            }
            
            guard let previousArtists = userDocument.data()?["artists"] as? [String] else {
                let error = NSError(domain: "GladeErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to read user's artists at Firestore path: \(userReference.path)"])
                errorPointer?.pointee = error
                return nil
            }
            
            for artist in previousArtists {
                let artistReference = db.collection("schools").document(school!).collection("artists").document(artist)
                
                // Database cleaning here if decrements to 0?
                transaction.updateData([
                    "user_count": FieldValue.increment(Int64(-1)), // Decrement by 1
                    "users": FieldValue.arrayRemove([username!])
                ], forDocument: artistReference)
                transaction.updateData([
                    "artists": FieldValue.arrayRemove([artist])
                ], forDocument: userReference)
            }
            return nil
        }) { (object, error) in
            if let error = error {
                print("Remove artists transaction failed", error)
            } else {
                print("Remove artists transaction succeeded")
                completion(true)
            }
        }
    }
    
    static func removeUserPreviousSongs(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        
        let username = UserDefaults.standard.string(forKey: "username")
        let userReference = db.collection("users").document(username!)
        let school = UserDefaults.standard.string(forKey: "school")
        
        db.runTransaction({ (transaction, errorPointer) -> Any?  in
            let userDocument: DocumentSnapshot
            do {
                try userDocument = transaction.getDocument(userReference)
            } catch let error as NSError {
                errorPointer?.pointee = error
                return nil
            }
            
            guard let previousSongs = userDocument.data()?["songs"] as? [String] else {
                let error = NSError(domain: "GladeErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to read user's songs at Firestore path: \(userReference.path)"])
                errorPointer?.pointee = error
                return nil
            }
            
            for song in previousSongs {
                let songReference = db.collection("schools").document(school!).collection("songs").document(song)
                
                // Database cleaning here if decrements to 0?
                transaction.updateData([
                    "user_count": FieldValue.increment(Int64(-1)), // Decrement by 1
                    "users": FieldValue.arrayRemove([username!])
                ], forDocument: songReference)
                transaction.updateData([
                    "songs": FieldValue.arrayRemove([song])
                ], forDocument: userReference)
            }
            return nil
        }) { (object, error) in
            if let error = error {
                print("Remove songs transaction failed", error)
                return
            } else {
                print("Remove songs transaction succeeded")
                completion(true)
            }
        }
    }
    
    static func storeUserTopArtists(completion: @escaping (Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        let accessToken = try! Token.getToken("accessToken", username: username!)
        
        getUserTopArtists(accessToken: accessToken) { (result, artists) in
            if result {
                print("Success - request top artists")

                // Remove current artists related to the user
                removeUserPreviousArtists() { (result) in
                    // Add new top artists related to the user
                    let group = DispatchGroup()
                    for artist in artists {
                        group.enter()
                        self.storeArtist(artist: artist) { (result) in
                            group.leave()
                        }
                    }
                    
                    group.notify(queue: .main) {
                        completion(true)
                    }
                }
            }
            else {
                print("Failure - request top artists")

            }
        }
    }
    
    static func storeUserTopSongs(completion: @escaping (Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        let accessToken = try! Token.getToken("accessToken", username: username!)
        
        // Add new top songs related to the user
        getUserTopSongs(accessToken: accessToken) { (result, songs) in
            print("Success - request top artists")
            if result {
                // Remove current songs related to the user
                removeUserPreviousSongs() { (result) in
                    // Add new top songs related to the user
                    let group = DispatchGroup()
                    for song in songs {
                        group.enter()
                        self.storeSong(song: song) { (result) in
                            group.leave()
                        }
                    }
                    group.notify(queue: .main) {
                        completion(true)
                    }
                }
            }
            else {
                print("Failure - request top artists")
            }
        }
    }
    
    static func getSchoolData(completion: @escaping (_ result: Bool, _ data: Dictionary<String, Any>) -> ()) {
        let db = Firestore.firestore()
        let school = UserDefaults.standard.string(forKey: "school")
        let schoolReference = db.collection("schools").document(school!)
        
        schoolReference.getDocument { (document, error) in
            if let error = error {
                print("Failed to get school's data from Firestore:", error)
                completion(false, [:])
            }
            else {
                if let document = document, document.exists {
                    let userCount = document.get("user_count")
                    completion(true, ["userCount": userCount!])
                }
            }
        }
    }
    
    static func getSchoolTopArtists(count: Int, completion: @escaping (_ result: Bool, _ artists: [Artist]) -> ()) {
        let db = Firestore.firestore()
        let school = UserDefaults.standard.string(forKey: "school")
        let artistsReference = db.collection("schools").document(school!).collection("artists")
        let artistsQuery = artistsReference.order(by: "user_count", descending: true).limit(to: count)
        
        artistsQuery.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Failed to get school's top artists:", error)
                completion(false, [])
            }
            else {
                var artists: [Artist] = []
                for document in querySnapshot!.documents {
                    let artist = try! FirestoreDecoder().decode(Artist.self, from: document.data())
                    artists.append(artist)
                    print("Success querying artist: \(artist.id!)")
                }
                completion(true, artists)
            }
        }
    }
    
    static func getSchoolTopSongs(count: Int, completion: @escaping (_ result: Bool, _ songs: [Song]) -> ()) {
        let db = Firestore.firestore()
        let school = UserDefaults.standard.string(forKey: "school")
        let songsReference = db.collection("schools").document(school!).collection("songs")
        let songsQuery = songsReference.order(by: "user_count", descending: true).limit(to: count)
        
        songsQuery.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Failed to get school's top songs:", error)
                completion(false, [])
            }
            else {
                var songs: [Song] = []
                for document in querySnapshot!.documents {
                    let song = try! FirestoreDecoder().decode(Song.self, from: document.data())
                    songs.append(song)
                    print("Success querying song: \(song.id!)")
                }
                completion(true, songs)
            }
        }
    }
}
