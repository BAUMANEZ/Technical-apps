//
//  RoverSelectionViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

struct RoverSelectionCellViewModel: TableViewCellViewModel {
    var cellType: UITableViewCell.Type
    var name: String
    var isSelected: Bool
}
