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
        guard let photoCellViewModel = viewModel as? PhotoCellViewModel else { return }
        let url = URL(string: photoCellViewModel.imageURL ?? "")
        Nuke.loadImage(with: url, into: imageView)
        titleLabel.text = photoCellViewModel.title
        subtitleLabel.text = photoCellViewModel.subtitle
    }
    
    private func configureTitleLabel() {
        titleLabel.setStyle(font: Body.normal, textAlignment: .left, numberOfLines: 1, textColor: .primary)
        
        titleLabel.activate(anchors: [.leading(0), .trailing(0)], relativeTo: contentView)
        titleLabel.activate(anchors: [
            .relative(attribute: .firstBaseline, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: 24)
        ], relativeTo: imageView)
    }
    
    private func configureSubtitleLabel() {
        subtitleLabel.setStyle(font: Header.small, textAlignment: .left, numberOfLines: 1, textColor: .lightGreen)
        
        subtitleLabel.activate(anchors: [
            .leading(0), .trailing(0),
            .relative(attribute: .lastBaseline, relation: .lessThanOrEqual, relatedTo: .bottom, multiplier: 1, constant: 0)
        ], relativeTo: contentView)
        
        subtitleLabel.activate(anchors: [
            .relative(attribute: .firstBaseline, relation: .equal, relatedTo: .lastBaseline, multiplier: 1, constant: 16)
        ], relativeTo: titleLabel)
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        
        imageView.activate(anchors: [
            .leading(0),
            .trailing(0),
            .top(0),
            .height(76)
        ], relativeTo: contentView)
    }
    
    private func addSubviews() {
        [imageView, titleLabel, subtitleLabel].forEach {
            _ = $0.useConstraints(on: contentView)
        }
    }
    
    private func configureSubiviews() {
        addSubviews()
        configureImageView()
        configureTitleLabel()
        configureSubtitleLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubiviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
