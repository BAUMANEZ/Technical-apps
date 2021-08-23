//
//  View.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

extension UIView {
//    func pin(to view: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
//        view.addSubview(self, anchors: [.top(top), .leading(leading), .bottom(-bottom), .trailing(-trailing)])
//    }
//    
    func useConstraints(on view: UIView? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        if let view = view {
            view.addSubview(self)
        }
        
        return self
    }
    
    func pin(to view: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        _ = self.useConstraints(on: view)
        view.preservesSuperviewLayoutMargins = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
