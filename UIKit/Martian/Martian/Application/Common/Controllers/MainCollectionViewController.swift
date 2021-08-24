//
//  MainCollectionViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionView: UICollectionView, CollectionViewDesignable  {
    var displayCells: [CollectionViewCellViewModel] = []
    
    func setStandartInteractionOptions() { }
    
    func registerCells() { }
    
}


class MainCollectionViewController: UICollectionViewController, ViewModelConnectable, CollectionViewControllerDesignable {
    var displayCells: [CollectionViewCellViewModel] = []
    
    func setStandartInteractionOptions() {
        
    }
    
    func registerCells() {
        
    }
    
    
    var viewModel: ViewModel?
    
    func assignViewModel() {
        
    }
    
    
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
}
