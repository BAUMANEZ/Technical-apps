//
//  CameraCellViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

struct CameraCellViewModel: TableViewCellViewModel {
    var cellType: UITableViewCell.Type
    var cameraName: String?
    var photos: [PhotoCellViewModell]
}
