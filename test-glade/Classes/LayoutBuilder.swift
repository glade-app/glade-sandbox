//
//  HomeLayoutBuilder.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import Foundation
import UIKit

public class LayoutBuilder {
    public static func buildSchoolSectionLayout(size: NSCollectionLayoutSize, itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    public static func buildProfileMainSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10)))
        let itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    public static func buildUsersSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(70),  heightDimension: .estimated(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    public static func buildSocialsSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200),  heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    public static func buildSongsSectionLayout(groupSize: NSCollectionLayoutSize, groupCount: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: groupCount)

        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        section.boundarySupplementaryItems = [headerItem]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    public static func buildArtistsSectionLayout(groupSize: NSCollectionLayoutSize, groupCount: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: groupCount)

        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        section.boundarySupplementaryItems = [headerItem]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
