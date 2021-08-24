//
//  PhotoCellViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

struct PhotoCellViewModell: CollectionViewCellViewModel {
    var cellType: UICollectionViewCell.Type
    var imageURL: String?
    var title: String?
    var subtitle: String?
}
