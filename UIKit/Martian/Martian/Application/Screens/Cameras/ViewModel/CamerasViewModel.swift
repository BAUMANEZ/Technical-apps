//
//  CamerasViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

class CamerasViewModel: StandartViewModel {
    enum DateSwitch {
        case next, previous
    }
    
    private(set) var date: Date?
    
    func switchDate(_ switcher: DateSwitch) {
        let increment: Int = switcher == DateSwitch.next ? 1 : -1
        if let previousDate = date {
            date = Calendar.current.date(byAdding: .day, value: increment, to: previousDate)
            let newDateString = DateFormatter().string(from: date ?? Date(), format: "yyyy-MM-dd")
            UserDefaults.standard.set(newDateString, forKey: "date")
        }
        update()
    }
    
    func loadDate() {
        if let dateString = UserDefaults.standard.string(forKey: "date") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            date = dateFormatter.date(from: dateString)
            update()
        }
    }
    
    private func update() {
        APIRequest.shared.parsePhotos(for: date ?? Date()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.model = photos
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
