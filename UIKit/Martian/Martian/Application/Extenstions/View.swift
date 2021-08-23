//
//  View.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

extension UIView {
    func pin(to view: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        view.addSubview(self, anchors: [.top(top), .leading(leading), .bottom(-bottom), .trailing(-trailing)])
    }
}
