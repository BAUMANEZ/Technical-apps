//
//  Label.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

extension UILabel {
    func setStyle(font: UIFont?,
                  textAlignment: NSTextAlignment = .center,
                  numberOfLines: Int = 1,
                  textColor: UIColor = .primary
                  ) {
        tintColor = textColor
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font ?? UIFont.boldSystemFont(ofSize: 30)
        self.numberOfLines = numberOfLines
    }
}
