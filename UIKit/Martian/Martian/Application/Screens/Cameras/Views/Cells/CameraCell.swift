//
//  CameraCell.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

class CameraCell: UITableViewCell, TableViewRepresentable, CollectionViewCellDisplayable {
    var collectionViewCells: [CollectionViewCellViewModel] = []
    
    var cellIndentifier: String = "CameraCell"
    
    private let cameraNameLabel = UILabel()
    private let showMoreImage = UIImageView()
    private let photosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    func setViewModel(_ viewModel: TableViewCellViewModel) {
        guard let cameraCellViewModel = viewModel as? CameraCellViewModel else { return }
        collectionViewCells = cameraCellViewModel.photos
        cameraNameLabel.text = cameraCellViewModel.cameraName
        photosCollectionView.reloadData()
    }
    
    private func configureCameraNameLabel() {
        cameraNameLabel.setStyle(font: Header.normal, textAlignment: .left, textColor: .primary)
        cameraNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func configureShowMoreButton() {
        let image = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        showMoreImage.image = image
        showMoreImage.contentMode = .left
    }
    
    private func configureNameAndShowMoreView() {
        configureCameraNameLabel()
        configureShowMoreButton()
        let containerStackview = UIStackView(arrangedSubviews: [cameraNameLabel, showMoreImage])
        containerStackview.setStyle(spacing: 10, axis: .horizontal, alignment: .fill, distribution: .fill)
        
        contentView.addSubview(containerStackview, anchors: [.leading(16), .top(0), .trailing(0)])
    }
    
    private func configureCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self

        contentView.addSubview(photosCollectionView, anchors: [.leading(16), .trailing(0), .bottom(0)])
        photosCollectionView.activate(anchors: [
            .relative(attribute: .top, relation: .equal, relatedTo: .lastBaseline, multiplier: 1, constant: 24)
        ], relativeTo: cameraNameLabel)
    }
    
    private func configureSubviews() {
        configureNameAndShowMoreView()
        configureCollectionView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        photosCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CameraCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = collectionViewCells[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(cellViewModel.cellType)", for: indexPath) as? CollectionViewRepresentable
        else {
            return UICollectionViewCell()
        }
        cell.setViewModel(cellViewModel)
        print(cell)
        return cell
    }
}
