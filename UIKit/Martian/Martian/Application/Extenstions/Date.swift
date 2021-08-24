//
//  Date.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import Foundation

extension DateFormatter {
    func string(from date: Date, format: String!) -> String {
        self.dateFormat = format
        return self.string(from: date)
    }

}
