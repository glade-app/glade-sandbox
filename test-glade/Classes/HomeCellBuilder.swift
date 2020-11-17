//
//  HomeCellBuilder.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit

public class HomeCellBuilder {
    public static func getSchoolCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "school", for: indexPath) as? HomeSchoolCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public static func getSongCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "song", for: indexPath) as? HomeSongCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
        
    public static func getArtistCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artist", for: indexPath) as? HomeArtistCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
