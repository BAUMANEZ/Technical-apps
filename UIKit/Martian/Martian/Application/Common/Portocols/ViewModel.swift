//
//  ViewModel.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import Foundation

protocol ViewModel {
    var model: Decodable? { get }
    var bindViewModelToView: (() -> ())? { get set }
}

protocol ViewModelConnectable {
    var viewModel: ViewModel? { get set}
    func assignViewModel()
}
