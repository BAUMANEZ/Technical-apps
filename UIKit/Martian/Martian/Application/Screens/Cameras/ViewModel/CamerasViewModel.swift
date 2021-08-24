//
//  CamerasViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 24.08.2021.
//

import UIKit

class CamerasViewModel: StandartViewModel {
    
    override func updateModel(completion: (() -> ())? = nil) {
        let day = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        APIRequest.shared.parsePhotos(for: day!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.model = photos
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            completion?()
        }
    }
}
