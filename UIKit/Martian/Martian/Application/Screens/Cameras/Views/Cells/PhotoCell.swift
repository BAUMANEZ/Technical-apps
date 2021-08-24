//
//  PhotoCell.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit
import Nuke

class PhotoCell: UICollectionViewCell, CollectionViewRepresentable {
    var cellIndentifier: String = "PhotoCell"
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()
    
    func setViewModel(_ viewModel: CollectionViewCellViewModel) {
        guard let photoCellViewModel = viewModel as? PhotoCellViewModell else { return }
        Nuke.loadImage(with: photoCellViewModel.imageURL, into: imageView)
        titleLabel.text = photoCellViewModel.title
        subtitleLabel.text = photoCellViewModel.subtitle
    }
    
    private func configureTitleLabel() {
        titleLabel.setStyle(font: Body.normal, textAlignment: .left, numberOfLines: 0, textColor: .primary)
        
        contentView.addSubview(titleLabel, anchors: [.leading(0), .trailing(0)])
        titleLabel.activate(anchors: [
            .relative(attribute: .firstBaseline, relation: .equal, relatedTo: .top, multiplier: 1, constant: 24)
        ], relativeTo: imageView)
    }
    
    private func configureSubtitleLabel() {
        subtitleLabel.setStyle(font: Body.small, textAlignment: .left, numberOfLines: 0, textColor: .lightGreen)
        
        contentView.addSubview(subtitleLabel, anchors: [
            .leading(0), .trailing(0),
            .relative(attribute: .lastBaseline, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: -8)
        ])
        subtitleLabel.activate(anchors: [
            .relative(attribute: .firstBaseline, relation: .equal, relatedTo: .lastBaseline, multiplier: 1, constant: 16)
        ], relativeTo: titleLabel)
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        
        contentView.addSubview(imageView, anchors: [.leading(0), .trailing(0), .top(0)])
        imageView.activate(anchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .width, multiplier: CGFloat(9 / 16), constant: 0)
        ], relativeTo: self)
    }
    
    private func configureSubiviews() {
        configureImageView()
        configureTitleLabel()
        configureSubtitleLabel()
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
