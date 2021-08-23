//
//  Cell.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

//MARK: - Cell Protocols
protocol CellViewModel {
    var cellType: UITableViewCell.Type { get }
}

protocol CellViewModelSettable: UITableViewCell {
    func setViewModel(_ viewModel: CellViewModel)
}

protocol CellIdentifiable: UITableViewCell {
    var cellIndentifier: String { get }
}

protocol TableViewRepresentable: CellIdentifiable, CellViewModelSettable {  }
