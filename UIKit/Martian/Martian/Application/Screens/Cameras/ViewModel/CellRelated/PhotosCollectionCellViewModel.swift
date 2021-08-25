//
//  CameraCellViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

struct PhotosCollectionCellViewModel: TableViewCellViewModel {
    var cellType: UITableViewCell.Type
    var photos: [PhotoCellViewModel]
}
