//
//  MainCollectionViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

class PhotoCollectionView: UICollectionView, CollectionViewDesignable {
    func registerCells() { }
    
    func setStandartInteractionOptions() {
        alwaysBounceHorizontal = false
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    
    init(scrollDirection: UICollectionView.ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        super.init(frame: .zero, collectionViewLayout: layout)
        setStandartInteractionOptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MainCollectionViewController: UICollectionViewController, ViewModelConnectable, CollectionViewControllerDesignable {
    var collectionViewCells: [CollectionViewCellViewModel] = []
    var viewModel: ViewModel?
    
    func setStandartInteractionOptions() { }
    
    func registerCells() { }
    
    func assignViewModel() { }
    
    func setStandartDesign() {
        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStandartDesign()
        setStandartInteractionOptions()
        setNavigationBar()
        registerCells()
    }

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
        (cell as? Delegatable)?.delegate = self
        cell.setViewModel(cellViewModel)
        return cell
    }
}

extension MainCollectionViewController: CellDelegate {}
