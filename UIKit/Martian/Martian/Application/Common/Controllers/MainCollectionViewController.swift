//
//  MainCollectionViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

class MainCollectionViewController: UICollectionViewController, ViewModelConnectable, CollectionViewControllerDesignable {
    var collectionViewCells: [CollectionViewCellViewModel] = []
    var viewModel: ViewModel?
    
    func setStandartInteractionOptions() { }
    
    func registerCells() { }
    
    func assignViewModel() { }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCells.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = collectionViewCells[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(cellViewModel.cellType)", for: indexPath) as? CollectionViewRepresentable
        else {
            return UICollectionViewCell()
        }
        cell.setViewModel(cellViewModel)
        return cell
    }
}
