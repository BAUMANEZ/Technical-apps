//
//  PhotoCell.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit
import Nuke

protocol PhotoCellDelegate: CellDelegate {
    func didTapPhoto(with image: UIImage?)
}

extension PhotoCellDelegate where Self: UIViewController {
    func didTapPhoto(with image: UIImage?) {
        let photoViewController = PhotoViewController(image: image)
        photoViewController.modalPresentationStyle = .formSheet
        (self as? UIViewController)?.present(photoViewController, animated: true)
    }
}

enum ImageScaleMode {
    case big, small
}

class PhotoCell: UICollectionViewCell, CollectionViewRepresentable, TappableAndDelegatable {
    weak var delegate: CellDelegate?
    
    var cellIndentifier: String = "PhotoCell"
    private var imageScaleMode: ImageScaleMode = .small {
        didSet {
            let heightConstant: CGFloat
            switch imageScaleMode {
            case .small:
                heightConstant = 76
            case .big:
                heightConstant = 104
            }
            imageView.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()
    
    func setViewModel(_ viewModel: CollectionViewCellViewModel) {
        guard let photoCellViewModel = viewModel as? PhotoCellViewModel else { return }
        let url = URL(string: photoCellViewModel.imageURL ?? "")
        Nuke.loadImage(with: url, into: imageView)
        titleLabel.text = photoCellViewModel.title
        subtitleLabel.text = photoCellViewModel.subtitle
        imageScaleMode = photoCellViewModel.imageScaleMode
    }
    
    //MARK: - Title
    
    private func configureTitleLabel() {
        titleLabel.setStyle(font: Body.normal, textAlignment: .left, numberOfLines: 1, textColor: .primary)
        
        titleLabel.activate(anchors: [.leading(0), .trailing(0)], relativeTo: contentView)
        titleLabel.activate(anchors: [
            .relative(attribute: .firstBaseline, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: 24)
        ], relativeTo: imageView)
    }
    
    //MARK: - Subtitle
    
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
    
    //MARK: - Image
    @objc func didTapImage() {
        (delegate as? PhotoCellDelegate)?.didTapPhoto(with: imageView.image)
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        addTapGestureTo(view: imageView, #selector(didTapImage))
        
        imageView.activate(anchors: [
            .leading(0),
            .trailing(0),
            .top(0)
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
