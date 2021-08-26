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

protocol CellDelegate: AnyObject { }

//MARK: - Table View Cell Protocols

protocol TableViewCellViewModel {
    var cellType: UITableViewCell.Type { get }
}

protocol TableViewCellViewModelSettable: UITableViewCell {
    func setViewModel(_ viewModel: TableViewCellViewModel)
}

protocol Delegatable: AnyObject {
    var delegate: CellDelegate? { get set }
}

protocol TappableAndDelegatable: Delegatable {
    func addTapGestureTo(view: UIView, _ selector: Selector)
}

extension TappableAndDelegatable {
    func addTapGestureTo(view: UIView, _ selector: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
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

