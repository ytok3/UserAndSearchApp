//
//  SearchCollectionViewFeatures.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 27.06.2022.
//

import UIKit

protocol SearchBarOutput: AnyObject {
    
    func getHeight() -> CGFloat
    func onSelected(ID: Int)
    func listSearchResults(values: [Search])
}

class SearchCollectionViewFeatures: NSObject {
    
    // MARK: Properties
    
    var search: [Search] = []
    weak var delegate: SearchBarOutput?
}

// MARK: Exensions

extension SearchCollectionViewFeatures: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return search.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Cell.CV_CELL, for: indexPath)
                as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.showCharacters(model: search[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelected(ID: search[indexPath.item].trackID ?? 0)
        print(search[indexPath.item].trackID ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = (delegate?.getHeight() ?? 300.0 ) / 4
        return CGSize(width: width, height: height)
    }
}
