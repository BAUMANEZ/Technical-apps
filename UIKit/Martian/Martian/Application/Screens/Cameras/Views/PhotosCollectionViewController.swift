//
//  PhotosCollectionViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 25.08.2021.
//

import UIKit

class PhotosCollectionViewController: MainCollectionViewController {
    override func registerCells() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    override func loadView() {
        collectionView = PhotoCollectionView(scrollDirection: .vertical)
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 187, height: .photoCellBigHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: .largeMargin, bottom: 0, right: .largeMargin)
    }
}
