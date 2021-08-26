//
//  ActivityIndicator.swift
//  Martian
//
//  Created by Арсений Токарев on 26.08.2021.
//

import UIKit

fileprivate var activityIndicator: UIActivityIndicatorView?

extension UIViewController {
    func showSpinner() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator?.startAnimating()
        if let activityIndicator = activityIndicator {
            view.addSubview(activityIndicator, anchors: [
                .centerY(0),
                .centerX(0)
            ])
        }
    }
    
    func hideSpinner() {
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}
