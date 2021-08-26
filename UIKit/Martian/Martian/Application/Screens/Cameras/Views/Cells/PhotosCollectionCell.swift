//
//  CameraCell.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

class PhotosCollectionCell: UITableViewCell, TableViewRepresentable, CollectionViewCellDisplayable, Delegatable {
    weak var delegate: CellDelegate?
    
    var collectionViewCells: [CollectionViewCellViewModel] = []
    var cellIndentifier: String = "PhotosCollectionCell"
    
    private let photosCollectionView = PhotoCollectionView(scrollDirection: .horizontal)
    
    func setViewModel(_ viewModel: TableViewCellViewModel) {
        guard let cameraCellViewModel = viewModel as? PhotosCollectionCellViewModel else { return }
        collectionViewCells = cameraCellViewModel.photos
        photosCollectionView.reloadData()
    }
    
    private func configureCollectionView() {

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.backgroundColor = .clear
        photosCollectionView.pin(to: contentView, leading: .largeMargin)
    }
    
    private func configureSubviews() {
        configureCollectionView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubviews()
        photosCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosCollectionCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = collectionViewCells[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(cellViewModel.cellType)", for: indexPath) as? CollectionViewRepresentable
        else {
            return UICollectionViewCell()
        }
        (cell as? Delegatable)?.delegate = delegate
        cell.setViewModel(cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: .photoCellSmallHeight)
    }
}

extension PhotosCollectionCell: PhotoCellDelegate {
    func didTapPhoto(with image: UIImage?) {
        (delegate as? PhotoCellDelegate)?.didTapPhoto(with: image)
    }
}
