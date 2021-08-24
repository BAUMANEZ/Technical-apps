//
//  PhotoCell.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit
import Nuke

class PhotoCell: UICollectionViewCell, CollectionViewCellViewModelSettable, Identifiable {
    var cellIdentifiel: String = "PhotoCell"
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()
    
    func setViewModel(_ viewModel: CollectionViewCellViewModel) {
        guard let photoCellViewModel = viewModel as? PhotoCellViewModell else { return }
        Nuke.loadImage(with: photoCellViewModel.imageURL, into: imageView)
        titleLabel.text = photoCellViewModel.title
        subtitleLabel.text = photoCellViewModel.subtitle
    }
    
    func configureTitleLabel() {
        _ = titleLabel.useConstraints(on: contentView)
        titleLabel.setStyle(font: Body.big, textAlignment: .left, numberOfLines: 0, textColor: .primary)
    }
    
    func configureSubtitleLabel() {
        _ = subtitleLabel.useConstraints(on: contentView)
        subtitleLabel.setStyle(font: Body.normal, textAlignment: .left, numberOfLines: 0, textColor: .lightGreen)
    }
    
    func configureImageView() {
        _ = imageView.useConstraints(on: contentView)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        
        imageView.activate(anchors: [.leading(0), .trailing(0), .top(0)], relativeTo: contentView)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
