//
//  HomeCellBuilder.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit

public class HomeCellBuilder {
    public static func getSchoolCell(collectionView: UICollectionView, indexPath: IndexPath, data: Dictionary<String, Any>) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "school", for: indexPath) as? HomeSchoolCollectionViewCell {
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    static func getSongCell(collectionView: UICollectionView, indexPath: IndexPath, data: Song) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "song", for: indexPath) as? HomeSongCollectionViewCell {
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
        
    static func getArtistCell(collectionView: UICollectionView, indexPath: IndexPath, data: Artist) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artist", for: indexPath) as? HomeArtistCollectionViewCell {
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
