//
//  HomeLayoutBuilder.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import Foundation
import UIKit

public class HomeLayoutBuilder {
    public static func buildSchoolSectionLayout(size: NSCollectionLayoutSize, itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0)) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    public static func buildSongSectionLayout(size: NSCollectionLayoutSize, itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 20.0, bottom: 10.0, trailing: 20.0)) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(240), heightDimension: .estimated(240)), subitem: item, count: 1)
        
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.interGroupSpacing = 20.0
        section.boundarySupplementaryItems = [headerItem]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    public static func buildArtistSectionLayout(size: NSCollectionLayoutSize, itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 20.0, bottom: 10.0, trailing: 20.0)) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(240), heightDimension: .estimated(240)), subitem: item, count: 1)
        
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.interGroupSpacing = 20.0
        section.boundarySupplementaryItems = [headerItem]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
}
