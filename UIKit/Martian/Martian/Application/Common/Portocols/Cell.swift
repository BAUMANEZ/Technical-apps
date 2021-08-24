//
//  Cell.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

protocol CellIdentifiable {
    var cellIndentifier: String { get }
}

//MARK: - Table View Cell Protocols

protocol TableViewCellViewModel {
    var cellType: UITableViewCell.Type { get }
}

protocol TableViewCellViewModelSettable: UITableViewCell {
    func setViewModel(_ viewModel: TableViewCellViewModel)
}

protocol TableViewRepresentable: CellIdentifiable, TableViewCellViewModelSettable {}


//MARK: - Collection View Cell Protocols
protocol CollectionViewCellViewModel {
    var cellType: UICollectionViewCell.Type { get }
}

protocol CollectionViewCellViewModelSettable: UICollectionViewCell {
    func setViewModel(_ viewModel: CollectionViewCellViewModel)
}

protocol CollectionViewRepresentable: CellIdentifiable, CollectionViewCellViewModelSettable {}

