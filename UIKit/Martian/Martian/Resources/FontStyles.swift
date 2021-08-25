//
//  FontStyles.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

struct Header {
    static let big      = UIFont(name: "Helvetica-Bold", size: 34)
    static let medium   = UIFont(name: "Helvetica-Bold", size: 16)
    static let standart = UIFont(name: "Helvetica-Bold", size: 12)
    static let small    = UIFont(name: "Helvetica-Bold", size: 8)
    private init() {}
}

struct Body {
    static let big    = UIFont(name: "Helvetica", size: 18)
    static let normal = UIFont(name: "Helvetica", size: 13)
    static let small  = UIFont(name: "Helvetica", size: 12)
    
    private init() {}
}
