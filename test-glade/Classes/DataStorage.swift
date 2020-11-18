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
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: userReference)
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
    
    static func storeArtist(artist: Artist) {
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
                                        "count": 1,
                                        "users": FieldValue.arrayUnion([username!])
                    ], forDocument: artistReference)
                    batch.updateData(["artists": FieldValue.arrayUnion([artist.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error writing artist data - \(artist.id!)", error)
                        }
                        else {
                            print("Success writing artist data - \(artist.id!)")
                        }
                    }
                }
                else {
                    let batch = db.batch()
                    batch.updateData([
                                        "users": FieldValue.arrayUnion([username!]),
                                        "count": FieldValue.increment(Int64(1)),
                    ], forDocument: artistReference)
                    batch.updateData(["artists": FieldValue.arrayUnion([artist.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error updating artist data - \(artist.id!)", error)
                        }
                        else {
                            print("Success updating artist data - \(artist.id!)")
                        }
                    }
                }
            }
        }
    }
    
    static func storeSong(song: Song) {
        let db = Firestore.firestore()
        let data = try! FirestoreEncoder().encode(song)
        
        let username = UserDefaults.standard.string(forKey: "username")
        let school = UserDefaults.standard.string(forKey: "school")
        
        let userReference = db.collection("users").document(username!)
        let songReference = db.collection("schools").document(school!).collection("songs").document(song.id!)

        // Try requesting the song's document from Firestore
        songReference.getDocument { (document, error) in
            if let document = document {
                // If the song's document doesn't exist
                if !document.exists {
                    let batch = db.batch()
                    batch.setData(data, forDocument: songReference)
                    batch.updateData([
                                        "count": 1,
                                        "users": FieldValue.arrayUnion([username!]),
                    ], forDocument: songReference)
                    batch.updateData(["songs": FieldValue.arrayUnion([song.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error writing song data - \(song.id!)", error)
                        }
                        else {
                            print("Success writing song data - \(song.id!)")
                        }
                    }
                }
                else {
                    let batch = db.batch()
                    batch.updateData([
                                        "users": FieldValue.arrayUnion([username!]),
                                        "count": FieldValue.increment(Int64(1))
                    ], forDocument: songReference)
                    batch.updateData(["songs": FieldValue.arrayUnion([song.id!])], forDocument: userReference)
                    batch.commit() { (error) in
                        if let error = error {
                            print("Error updating song data - \(song.id!)", error)
                        }
                        else {
                            print("Success updating song data - \(song.id!)")
                        }
                    }
                }
            }
        }
    }
    
    static func storeUserTopArtists() {
        let accessToken = try! Token.getToken("Access Token")

        getUserTopArtists(accessToken: accessToken) { (result, artists) in
            if result {
                // Remove current artists related to the user
                
                // Add new top artists related to the user
                for artist in artists {
                    self.storeArtist(artist: artist)
                }
                print("Success - request top artists")
            }
            else {
                print("Failure - request top artists")
            }
        }
    }
    
    static func storeUserTopSongs() {
        let accessToken = try! Token.getToken("Access Token")
        
        // Remove current songs related to the user
        
        // Add new top songs related to the user
        getUserTopSongs(accessToken: accessToken) { (result, songs) in
            if result {
                for song in songs {
                    self.storeSong(song: song)
                }
                print("Success - request top artists")
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
        let artistsQuery = artistsReference.order(by: "count", descending: true).limit(to: count)
        
        artistsQuery.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Failed to get school's top artists:", error)
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
        let songsQuery = songsReference.order(by: "count", descending: true).limit(to: count)
        
        songsQuery.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Failed to get school's top songs:", error)
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
