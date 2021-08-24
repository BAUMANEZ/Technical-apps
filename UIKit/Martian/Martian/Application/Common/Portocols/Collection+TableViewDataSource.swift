//
//  Collection+TableViewDelegate.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

extension UITableViewDataSource where Self: TableViewCellDisplayable {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = tableViewCells[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(cellViewModel.cellType)", for: indexPath) as? TableViewRepresentable
        else {
            return UITableViewCell()
        }
        cell.setViewModel(cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UICollectionViewDataSource where Self: CollectionViewCellDisplayable {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = collectionViewCells[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(cellViewModel.cellType)", for: indexPath) as? CollectionViewRepresentable
        else {
            return UICollectionViewCell()
        }
        cell.setViewModel(cellViewModel)
        return cell
    }
}
