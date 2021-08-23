//
//  File.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class TableViewSpacer: UIView {
    enum SeparatorPosition {
        case top
        case bottom
    }
    
    lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    init(separatedFrom: SeparatorPosition? = nil) {
        super.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: 41).isActive = true
        if let separatorPosition = separatedFrom {
            let verticalAnchor: LayoutAnchor
            switch separatorPosition {
            case .top:
                verticalAnchor = .top(0)
            case .bottom:
                verticalAnchor = .bottom(0)
            }
            addSubview(separator, anchors: [verticalAnchor, .leading(0), .trailing(0), .height(1)])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
