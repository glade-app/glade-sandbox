//
//  DataStorage.swift
//  test-glade
//
//  Created by Allen Gu on 11/13/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import CodableFirebase
// https://github.com/alickbass/CodableFirebase

class DataStorage {
    /// User Data
    static func getUserData(username: String, completion: @escaping (_ result: Bool, _ user: User) -> ()) {
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username)
        
        userReference.getDocument { (document, error) in
            if let error = error {
                print("Failed to get school's data from Firestore:", error)
            }
            else {
                if let document = document, document.exists {
                    let user = try! FirestoreDecoder().decode(User.self, from: document.data()!)
                    completion(true, user)
                }
            }
        }
    }
    
    static func storeUserData(user: User, completion: @escaping (_ result: Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        // Save username to UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(username, forKey: "username")
        
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
    
    static func ifUserExists(completion: @escaping (_ result: Bool) -> ()) {
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
    
    /// Artist Data
    static func getUserTopArtists(count: Int, user: User, completion: @escaping (_ result: Bool, _ artists: [Artist]) -> ()) {
        let db = Firestore.firestore()
        let username = user.id
        let userReference = db.collection("users").document(username!)
        
        userReference.getDocument() { (document, error) in
            if let document = document {
                // If user does not already exist in the database
                if document.exists {
                    let artistIDsResponse: [String] = document.get("artists") as! [String]
                    let artistIDs: [String] = Array(artistIDsResponse.prefix(min(count, artistIDsResponse.count)))
                    var artists: [Artist] = []
                    let group = DispatchGroup()
                    for id in artistIDs {
                        group.enter()
                        let artistReference = db.collection("artists").document(id)
                        artistReference.getDocument() { (artistDocument, error) in
                            if let artistDocument = artistDocument {
                                if artistDocument.exists {
                                    let artist = try! FirestoreDecoder().decode(Artist.self, from: artistDocument.data()!)
                                    artists.append(artist)
                                    print("Success querying artist: \(artist.id!)")
                                }
                                group.leave()
                            }
                            else {
                                print("Failed to get artist document - \(id) -", error)
                                group.leave()
                            }
                        }
                    }
                    group.notify(queue: .main) {
                        completion(true, artists)
                    }
                }
            }
        }
    }
    
    static func storeArtist(artist: Artist, completion: @escaping (_ result: Bool) -> ()) {
        let db = Firestore.firestore()
        let data = try! FirestoreEncoder().encode(artist)
        
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        let userReference = db.collection("users").document(username!)
        let artistReference = db.collection("artists").document(artist.id!)
        let schoolArtistReference = db.collection("schools").document(school!).collection("artists").document(artist.id!)
        
        // Try requesting the artist's document from Firestore
        artistReference.getDocument { (document, error) in
            if let document = document {
                // If the artist's document doesn't exist
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: artistReference)
                    batch.setData([
                                        "user_count": 1,
                                        "users": FieldValue.arrayUnion([username!])
                    ], forDocument: schoolArtistReference)
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
                    ], forDocument: schoolArtistReference)
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
    
    static func removeUserPreviousArtists(completion: @escaping (_ result: Bool) -> ()) {
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
                let schoolArtistReference = db.collection("schools").document(school!).collection("artists").document(artist)
                
                // Database cleaning here if decrements to 0?
                transaction.updateData([
                    "user_count": FieldValue.increment(Int64(-1)), // Decrement by 1
                    "users": FieldValue.arrayRemove([username!])
                ], forDocument: schoolArtistReference)
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
    
    static func storeUserTopArtists(artists: [Artist], completion: @escaping (_ result: Bool) -> ()) {
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
    
    /// Song Data
    static func getUserTopSongs(count: Int, user: User, completion: @escaping (_ result: Bool, _ songs: [Song]) -> ()) {
        let db = Firestore.firestore()
        let username = user.id
        let userReference = db.collection("users").document(username!)
        
        userReference.getDocument() { (document, error) in
            if let document = document {
                // If user does not already exist in the database
                if document.exists {
                    let songIDsResponse: [String] = document.get("songs") as! [String]
                    let songIDs: [String] = Array(songIDsResponse.prefix(min(count, songIDsResponse.count)))
                    var songs: [Song] = []
                    let group = DispatchGroup()
                    for id in songIDs {
                        group.enter()
                        let songReference = db.collection("songs").document(id)
                        songReference.getDocument() { (songDocument, error) in
                            if let songDocument = songDocument {
                                if songDocument.exists {
                                    let song = try! FirestoreDecoder().decode(Song.self, from: songDocument.data()!)
                                    songs.append(song)
                                    print("Success querying artist: \(song.id!)")
                                }
                                group.leave()
                            }
                            else {
                                print("Failed to get artist document - \(id) -", error)
                                group.leave()
                            }
                        }
                    }
                    group.notify(queue: .main) {
                        completion(true, songs)
                    }
                }
            }
        }
    }
    
    static func storeSong(song: Song, completion: @escaping (_ result: Bool) -> ()) {
        let db = Firestore.firestore()
        let data = try! FirestoreEncoder().encode(song)
        
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        let userReference = db.collection("users").document(username!)
        let songReference = db.collection("songs").document(song.id!)
        let schoolSongReference = db.collection("schools").document(school!).collection("songs").document(song.id!)

        // Try requesting the song's document from Firestore
        songReference.getDocument { (document, error) in
            if let document = document {
                // If the song's document doesn't exist, first set the document data
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: songReference)
                    batch.setData([
                                        "user_count": 1,
                                        "users": FieldValue.arrayUnion([username!]),
                    ], forDocument: schoolSongReference)
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
                    ], forDocument: schoolSongReference)
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
    
    static func removeUserPreviousSongs(completion: @escaping (_ result: Bool) -> ()) {
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
                let schoolSongReference = db.collection("schools").document(school!).collection("songs").document(song)
                
                // Database cleaning here if decrements to 0?
                transaction.updateData([
                    "user_count": FieldValue.increment(Int64(-1)), // Decrement by 1
                    "users": FieldValue.arrayRemove([username!])
                ], forDocument: schoolSongReference)
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
    
    static func storeUserTopSongs(songs: [Song], completion: @escaping (_ result: Bool) -> ()) {
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
    
    /// School Data
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
    
    static func getSchoolTopArtists(count: Int, completion: @escaping (_ result: Bool, _ artists: [Artist?]) -> ()) {
        let db = Firestore.firestore()
        let school = UserDefaults.standard.string(forKey: "school")
        let schoolArtistsReference = db.collection("schools").document(school!).collection("artists")
        let schoolArtistsQuery = schoolArtistsReference.order(by: "user_count", descending: true).limit(to: count)
        
        schoolArtistsQuery.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Failed to get school's top artists:", error)
            }
            else {
                var artists: [Artist?] = Array.init(repeating: nil, count: querySnapshot!.documents.count)
                let group = DispatchGroup()
                for i in 0...querySnapshot!.documents.count - 1 {
                    group.enter()
                    let document = querySnapshot!.documents[i]
                    let id = document.documentID
                    let users: [String] = document.get("users") as! [String]
                    
                    let artistReference = db.collection("artists").document(id)
                    artistReference.getDocument() { (artistDocument, error) in
                        if let artistDocument = artistDocument {
                            if artistDocument.exists {
                                var artist = try! FirestoreDecoder().decode(Artist.self, from: artistDocument.data()!)
                                artist.users = users
                                artists[i] = artist
                                print("Success querying artist: \(artist.id!)")
                            }
                            group.leave()
                        }
                        else {
                            print("Failed to get artist document - \(id) -", error)
                            group.leave()
                        }
                    }
                }
                group.notify(queue: .main) {
                    completion(true, artists)
                }
            }
        }
    }
    
    static func getSchoolTopSongs(count: Int, completion: @escaping (_ result: Bool, _ songs: [Song?]) -> ()) {
        let db = Firestore.firestore()
        let school = UserDefaults.standard.string(forKey: "school")
        let schoolSongsReference = db.collection("schools").document(school!).collection("songs")
        let schoolSongsQuery = schoolSongsReference.order(by: "user_count", descending: true).limit(to: count)
        
        schoolSongsQuery.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Failed to get school's top songs:", error)
            }
            else {
                var songs: [Song?] = Array.init(repeating: nil, count: querySnapshot!.documents.count)
                let group = DispatchGroup()
                for i in 0...querySnapshot!.documents.count - 1 {
                    group.enter()
                    let document = querySnapshot!.documents[i]
                    let id = document.documentID
                    let users: [String] = document.get("users") as! [String]
                    
                    let songReference = db.collection("songs").document(id)
                    songReference.getDocument() { (document, error) in
                        if let document = document {
                            if document.exists {
                                var song = try! FirestoreDecoder().decode(Song.self, from: document.data()!)
                                song.users = users
                                songs[i] = song
                                print("Success querying song: \(song.id!)")
                            }
                            group.leave()
                        }
                        else {
                            print("Failed to get song document - \(id) -", error)
                            group.leave()
                        }
                    }
                }
                group.notify(queue: .main) {
                    completion(true, songs)
                }
            }
        }
    }
}
