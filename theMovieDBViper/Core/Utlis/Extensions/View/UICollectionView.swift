//
//  UICollectionView.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 02/10/23.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func createCustomCompotionalSection(
        itemSize: NSCollectionLayoutSize,
        groupSize: NSCollectionLayoutSize,
        sectionPaddingSize: NSDirectionalEdgeInsets? = nil,
        itemPaddingSize: NSDirectionalEdgeInsets? = nil,
        groupPaddingSize: NSDirectionalEdgeInsets? = nil,
        sectionHeaderSize: NSCollectionLayoutSize? = nil,
        sectionFooterSize: NSCollectionLayoutSize? = nil
    ) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        if let itemPadding = itemPaddingSize {
            item.contentInsets = itemPadding
        }

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        if let groupPadding = groupPaddingSize {
            group.contentInsets = groupPadding
        }
        
        let sectionLayout = NSCollectionLayoutSection(group: group)
        if let sectionPadding = sectionPaddingSize {
            sectionLayout.contentInsets = sectionPadding
        }
        
        if let headerSize = sectionHeaderSize {
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            sectionLayout.boundarySupplementaryItems = [header]
        }

        if let footerSize = sectionFooterSize {
            let footer = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            sectionLayout.boundarySupplementaryItems = [footer]
        }
        return sectionLayout
    }
    
    func movieListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let itemPadding = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
        let groupPadding = NSDirectionalEdgeInsets(top: 15, leading: 6, bottom: 0, trailing: 6)
        let movieListSection = createCustomCompotionalSection(itemSize: itemSize, groupSize: groupSize, itemPaddingSize: itemPadding, groupPaddingSize: groupPadding)
        return movieListSection
        
    }
}
