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
    
    func setViewModel(_ viewModel: TableViewCellViewModel) {
        guard let viewModel = viewModel as? RoverSelectionCellViewModel else { return }
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
        titleLabel.setStyle(font: Body.normal, textAlignment: .left)
        
        contentView.addSubview(titleLabel, anchors: [
            .leading(16),
            .relative(attribute: .firstBaseline, relation: .equal, relatedTo: .top, multiplier: 1, constant: 26),
            .relative(attribute: .lastBaseline, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: -18)
        ])
        titleLabel.trailingAnchor.constraint(equalTo: checkboxImageView.leadingAnchor, constant: -16).isActive = true
    }
    
    private func configureImageView() {
        checkboxImageView.image = UIImage(named: "checkbox")?.withRenderingMode(.alwaysOriginal)
        checkboxImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(checkboxImageView, anchors: [
            .top(12),
            .trailing(-16),
            .width(20), .height(20)
        ])
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
