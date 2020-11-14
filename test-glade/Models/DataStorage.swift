//
//  DataStorage.swift
//  test-glade
//
//  Created by Allen Gu on 11/13/20.
//

import Foundation
import Alamofire
import Firebase
import CodableFirebase
// https://github.com/alickbass/CodableFirebase

class DataStorage {
    static func saveUserData(user: User, completion: @escaping (_ result: Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username!)

        let data = try! FirestoreEncoder().encode(user)
        userReference.getDocument { (document, error) in
            if let document = document {
                if !document.exists {
                    // If user doesn't exist, first create a document and set the data
                    userReference.setData(data) { error in
                        if let error = error {
                            print("Failed to write user to database", error)
                        } else {
                            print("Successfully wrote user in databse")
                            completion(true)
                        }
                    }
                }
                else {
                    // If user already exists, update the data in the document
                    userReference.updateData(data) { error in
                        if let error = error {
                            print("Failed to update user to database", error)
                        } else {
                            print("Successfully updated user in database")
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
    static func saveUserSchool(school: String) {
        let username = UserDefaults.standard.string(forKey: "username")
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username!)
        
        userReference.setData([
            "school": school
        ]) { error in
            if let error = error {
                print("Failed to write school to user's database", error)
            } else {
                print("Successfully wrote school to user's database")
            }
        }
    }
    
    static func saveUserFieldValue(field: String, value: Any) {
        let username = UserDefaults.standard.string(forKey: "username")
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username!)
        
        userReference.updateData([
            field: value
        ]) { error in
            if let error = error {
                print("Failed to write description to user's database", error)
            } else {
                print("Successfully wrote description to user's database")
            }
        }
    }
    
    static func updateUserFieldValue(field: String, value: String) {
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
    
    static func updateUserFieldValue(field: String, value: Array<Any>) {
        let username = UserDefaults.standard.string(forKey: "username")
        let db = Firestore.firestore()
        let userReference = db.collection("users").document(username!)
        
        userReference.updateData([
            field: FieldValue.arrayUnion(value)
        ]) { error in
            if let error = error {
                print("Failed to write \(field) to user's database", error)
            } else {
                print("Successfully wrote \(field) to user's database")
            }
        }
    }
    
    static func getTopArtists(accessToken: String, completion: @escaping (_ result: Bool, _ artists: [Artist]) -> ()) {
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
    
    static func getTopSongs(accessToken: String, completion: @escaping (_ result: Bool, _ artists: [Song]) -> ()) {
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
    
    static func checkNewArtist(artist: Artist, artistReference: DocumentReference, completion: @escaping (Bool) -> Void) {
        let data = try! FirestoreEncoder().encode(artist)
        // Try requesting the artist's document from Firestore
        artistReference.getDocument { (document, error) in
            if let document = document {
                // If the artist's document doesn't exist
                if !document.exists {
                    // Then try setting the artist data in the document
                    artistReference.setData(data) { error in
                        if let error = error {
                            print("Error writing artist data", error)
                        } else {
                            completion(true)
                            print("Successful writing artist data to Firestore - \(artist.id!)")
                        }
                    }
                }
                // If the artist's document already exists, just run the completion handler which adds additional info to the artist
                else {
                    completion(true)
                }
            }
        }
    }
    
    static func checkNewSong(song: Song, songReference: DocumentReference, completion: @escaping (Bool) -> Void) {
        let data = try! FirestoreEncoder().encode(song)
        // Try requesting the artist's document from Firestore
        songReference.getDocument { (document, error) in
            if let document = document {
                // If the artist's document doesn't exist
                if !document.exists {
                    // Then try setting the artist data in the document
                    songReference.setData(data) { error in
                        if let error = error {
                            print("Error writing song data", error)
                        } else {
                            completion(true)
                            print("Successful writing song data to Firestore - \(song.id!)")
                        }
                    }
                }
                // If the song's document already exists, just run the completion handler which adds additional info to the song
                else {
                    completion(true)
                }
            }
        }
    }
    
    static func saveTopArtists() {
        let accessToken = try! Token.getToken("Access Token")
        let username = UserDefaults.standard.string(forKey: "username")
        
        let db = Firestore.firestore()
        getTopArtists(accessToken: accessToken) { (result, artists) in
            if result {
                for artist in artists {
                    // Firestore
                    let artistReference = db.collection("artists").document(artist.id!)
                    let userReference = db.collection("users").document(username!)
                    self.checkNewArtist(artist: artist, artistReference: artistReference) { result in
                        // Completion handler for setting a new artist
                        // If the artist is set, then we update 1) the user document's artists array and 2) the artist document's users array
                        db.runTransaction({ (transaction, errorPointer ) -> Any? in
                            transaction.updateData([
                                "users": FieldValue.arrayUnion([username!])
                            ], forDocument: artistReference)
                            transaction.updateData([
                                "artists": FieldValue.arrayUnion([artist.id!])
                            ], forDocument: userReference)
                            return nil
                        }) { (object, error) in
                            if let error = error {
                                print(error)
                            }
                        }
                    }
                }
                print("Success - request top artists")
            }
            else {
                print("Failure - request top artists")
            }
        }
    }
    
    static func saveTopSongs() {
        let accessToken = try! Token.getToken("Access Token")
        let username = UserDefaults.standard.string(forKey: "username")
        
        let db = Firestore.firestore()
        getTopSongs(accessToken: accessToken) { (result, songs) in
            if result {
                for song in songs {
                    // Firestore
                    let songReference = db.collection("songs").document(song.id!)
                    let userReference = db.collection("users").document(username!)
                    self.checkNewSong(song: song, songReference: songReference) { result in
                        // Completion handler for setting a new artist
                        // If the artist is set, then we update 1) the user's document with the artist and 2) the artist's document with the user
                        db.runTransaction({ (transaction, errorPointer ) -> Any? in
                            transaction.updateData([
                                "users": FieldValue.arrayUnion([username!])
                            ], forDocument: songReference)
                            transaction.updateData([
                                "songs": FieldValue.arrayUnion([song.id!])
                            ], forDocument: userReference)
                            return nil
                        }) { (object, error) in
                            if let error = error {
                                print(error)
                            }
                        }
                    }
                }
                print("Success - request top artists")
            }
            else {
                print("Failure - request top artists")
            }
        }
    }
}
