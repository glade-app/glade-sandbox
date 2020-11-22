//
//  Spotify.swift
//  test-glade
//
//  Created by Allen Gu on 11/21/20.
//

import Alamofire

class Spotify {
    static func getUserData(accessToken: String, completion: @escaping (_ result: Bool, _ user: User) -> ()) {
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: accessToken)]
        let request = AF.request("https://api.spotify.com/v1/me", headers: headers)
        request.responseDecodable(of: User.self) { (response) in
            guard var user = response.value else {
                print("Failed to decode")
                return
            }
            user.school = UserDefaults.standard.string(forKey: "school")
            print(user)
            
            completion(true, user)
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
}
