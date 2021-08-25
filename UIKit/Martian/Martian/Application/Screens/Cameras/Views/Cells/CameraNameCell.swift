//
//  CameraNameCell.swift
//  Martian
//
//  Created by Арсений Токарев on 25.08.2021.
//

import UIKit

class CameraNameCell: UITableViewCell, TableViewRepresentable {
    var cellIndentifier: String = "CameraNameCell"
    
    private let cameraNameLabel = UILabel()
    private let showMoreImage = UIImageView()
    
    func setViewModel(_ viewModel: TableViewCellViewModel) {
        guard let cameraNameCellViewModel = viewModel as? CameraNameCellViewModel else { return }
        cameraNameLabel.text = cameraNameCellViewModel.cameraName
    }
    
    private func configureCameraNameLabel() {
        cameraNameLabel.setStyle(font: Header.medium, textAlignment: .left, textColor: .primary)
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
        let containerStackView = UIStackView(arrangedSubviews: [cameraNameLabel, showMoreImage])
        containerStackView.setStyle(spacing: 10, axis: .horizontal, alignment: .fill, distribution: .fill)

        containerStackView.pin(to: contentView, top: 16, leading: 16, bottom: -16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNameAndShowMoreView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
