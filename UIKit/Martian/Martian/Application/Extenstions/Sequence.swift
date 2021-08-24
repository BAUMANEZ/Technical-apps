//
//  Sequence.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
