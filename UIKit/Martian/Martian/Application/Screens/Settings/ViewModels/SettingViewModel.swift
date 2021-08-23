//
//  SettingViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class SettingsViewModel: ViewModel {
    var bindViewModelToView: (() -> ())?
    
     private(set) var model: Decodable? {
        didSet {
            bindViewModelToView?()
        }
    }
    
    
    func updateModel(completion: (() -> ())? = nil) {
        APIRequest.shared.parseRovers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rovers):
                self.model = rovers
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            completion?()
        }
    }
    
    init() {
        updateModel()
    }
}
