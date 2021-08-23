//
//  StackView.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

extension UIStackView {
    func setStyle(spacing: CGFloat,
                  axis: NSLayoutConstraint.Axis,
                  alignment: UIStackView.Alignment = .center,
                  distribution: UIStackView.Distribution = .fill,
                  margins: NSDirectionalEdgeInsets? = nil,
                  isBaselineRelativeArrangement: Bool = false) {
        self.spacing = spacing
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        if let insets = margins {
            isLayoutMarginsRelativeArrangement = true
            directionalLayoutMargins = insets
        } else {
            isLayoutMarginsRelativeArrangement = false
        }
        self.isBaselineRelativeArrangement = isBaselineRelativeArrangement
    }
}
