//
//  HomeCellBuilder.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit

public class CellBuilder {
    public static func getSchoolCell(collectionView: UICollectionView, indexPath: IndexPath, data: Dictionary<String, Any>) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "school", for: indexPath) as? HomeSchoolCollectionViewCell {
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public static func getProfileMainCell(collectionView: UICollectionView, indexPath: IndexPath, data: User) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileMain", for: indexPath) as? ProfileMainCollectionViewCell {
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public static func getSocialCell(collectionView: UICollectionView, indexPath: IndexPath, social: Social) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "social", for: indexPath) as? SocialCollectionViewCell {
            cell.configure(social: social)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    static func getUserCell(collectionView: UICollectionView, indexPath: IndexPath, data: User) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "user", for: indexPath) as? UserCollectionViewCell {
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    static func getSongCell(collectionView: UICollectionView, indexPath: IndexPath, data: Song) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "song", for: indexPath) as? SongCollectionViewCell {
            cell.configure(data: data, index: indexPath.item)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
        
    static func getArtistCell(collectionView: UICollectionView, indexPath: IndexPath, data: Artist) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artist", for: indexPath) as? ArtistCollectionViewCell {
            cell.configure(data: data, index: indexPath.item)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
