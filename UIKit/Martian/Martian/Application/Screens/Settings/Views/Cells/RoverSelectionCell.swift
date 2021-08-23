//
//  RoverSelectionCell.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class RoverSelectionCell: UITableViewCell, TableViewRepresentable {
    var cellIndentifier: String = "RoverSelectionCell"
    
    private let titleLabel = UILabel()
    private let checkboxImageView = UIImageView()
    
    
    func setViewModel(_ viewModel: CellViewModel) {
        guard let viewModel = viewModel as? RoverSelectionViewModel else { return }
        titleLabel.text = viewModel.name
        if viewModel.isSelected {
            titleLabel.textColor = .selected
            checkboxImageView.isHidden = false
        } else {
            titleLabel.textColor = .primary
            checkboxImageView.isHidden = true
        }
    }
    
    private func configureLabel() {
        _ = titleLabel.useConstraints(on: contentView)
        titleLabel.setStyle(font: Body.normal, textAlignment: .left)
        
        titleLabel.firstBaselineAnchor.constraint(equalTo: contentView.topAnchor, constant: 26).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: checkboxImageView.leadingAnchor, constant: -16).isActive = true
    }
    
    private func configureImageView() {
        _ = checkboxImageView.useConstraints(on: contentView)
        checkboxImageView.image = UIImage(named: "checkbox")?.withRenderingMode(.alwaysOriginal)
        checkboxImageView.contentMode = .scaleAspectFit
        
        checkboxImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        checkboxImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        checkboxImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkboxImageView.heightAnchor.constraint(equalTo: checkboxImageView.widthAnchor).isActive = true
    }
    
    private func configureSubviews() {
        configureImageView()
        configureLabel()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
