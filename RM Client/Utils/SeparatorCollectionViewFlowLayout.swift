//
//  SeparatorCollectionViewFlowLayout.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation
import UIKit

class SeparatorCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var indexPathsToInsert: [IndexPath] = []
    private var indexPathsToDelete: [IndexPath] = []
    
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        for item in updateItems {
            switch item.updateAction {
            case .delete:
                if let indexPath = item.indexPathBeforeUpdate {
                    indexPathsToDelete.append(indexPath)
                }
                
            case .insert:
                if let indexPath = item.indexPathAfterUpdate {
                    indexPathsToInsert.append(indexPath)
                }
                
            default:
                break
            }
        }
    }
    
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        indexPathsToDelete.removeAll()
        indexPathsToInsert.removeAll()
    }
    
    
    override func indexPathsToDeleteForDecorationView(ofKind elementKind: String) -> [IndexPath] {
        return indexPathsToDelete
    }
    
    
    override func indexPathsToInsertForDecorationView(ofKind elementKind: String) -> [IndexPath] {
        return indexPathsToInsert
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributesArray = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var decorationAttributes: [UICollectionViewLayoutAttributes] = []
        for layoutAttributes in layoutAttributesArray {
            
            let indexPath = layoutAttributes.indexPath
            if let separatorAttributes = layoutAttributesForDecorationView(ofKind: CollectionSeparatorView.reusableIdentifier, at: indexPath) {
                if rect.intersects(separatorAttributes.frame) {
                    decorationAttributes.append(separatorAttributes)
                }
            }
        }
        
        let allAttributes = layoutAttributesArray + decorationAttributes
        return allAttributes
    }
    
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let cellAttributes = layoutAttributesForItem(at: indexPath) else {
            return createAttributesForMyDecoration(at: indexPath)
        }
        return layoutAttributesForMyDecoratinoView(at: indexPath, for: cellAttributes.frame, state: .normal)
    }
    
    
    override func initialLayoutAttributesForAppearingDecorationElement(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let cellAttributes = initialLayoutAttributesForAppearingItem(at: indexPath) else {
            return createAttributesForMyDecoration(at: indexPath)
        }
        return layoutAttributesForMyDecoratinoView(at: indexPath, for: cellAttributes.frame, state: .initial)
    }
    
    
    override func finalLayoutAttributesForDisappearingDecorationElement(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let cellAttributes = finalLayoutAttributesForDisappearingItem(at: indexPath) else {
            return createAttributesForMyDecoration(at: indexPath)
        }
        return layoutAttributesForMyDecoratinoView(at: indexPath, for: cellAttributes.frame, state: .final)
    }
    
    
    // MARK: - privates
    
    private enum State {
        case initial
        case normal
        case final
    }
    
    
    private func setup() {
        register(CollectionSeparatorView.self, forDecorationViewOfKind: CollectionSeparatorView.reusableIdentifier)
    }
    
    
    private func createAttributesForMyDecoration(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        return UICollectionViewLayoutAttributes(forDecorationViewOfKind: CollectionSeparatorView.reusableIdentifier, with: indexPath)
    }
    
    
    private func layoutAttributesForMyDecoratinoView(at indexPath: IndexPath, for cellFrame: CGRect, state: State) -> UICollectionViewLayoutAttributes? {
        
        guard let rect = collectionView?.bounds else {
            return nil
        }
        
        //Add separator for every row except the first
        guard indexPath.item > 0 else {
            return nil
        }
        
        let separatorAttributes = createAttributesForMyDecoration(at: indexPath)
        separatorAttributes.alpha = 1.0
        separatorAttributes.isHidden = false
        
        let firstCellInRow = cellFrame.origin.x < cellFrame.width
        if firstCellInRow {
            // horizontal line
            separatorAttributes.frame = CGRect(x: rect.minX, y: cellFrame.origin.y - minimumLineSpacing, width: rect.width, height: minimumLineSpacing)
            separatorAttributes.zIndex = 1000
            
        } else {
            // vertical line
            separatorAttributes.frame = CGRect(x: cellFrame.origin.x - minimumInteritemSpacing, y: cellFrame.origin.y, width: minimumInteritemSpacing, height: cellFrame.height)
            separatorAttributes.zIndex = 1000
        }
        
        // Sync the decorator animation with the cell animation in order to avoid blinkining
        switch state {
        case .normal:
            separatorAttributes.alpha = 1
        default:
            separatorAttributes.alpha = 0.1
        }
        
        return separatorAttributes
    }
}
