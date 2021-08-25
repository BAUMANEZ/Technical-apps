//
//  SettingViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class StandartViewModel: ViewModel {
    var bindViewModelToView: (() -> ())?
    
    var model: Decodable? {
        didSet {
            bindViewModelToView?()
        }
    }
}

class SettingsViewModel: StandartViewModel {
    func getRoversFrom(_ model: Decodable) {
        self.model = model
    }
}
