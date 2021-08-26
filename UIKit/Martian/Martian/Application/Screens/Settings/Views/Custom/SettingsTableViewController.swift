//
//  SettingsTableViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class SettingsTableViewController: MainTableViewController {
    
    override func registerCells() {
        tableView.register(RoverSelectionCell.self, forCellReuseIdentifier: "RoverSelectionCell")
    }
    
    override func assignViewModel() {
        viewModel = SettingsViewModel()
        viewModel?.bindViewModelToView = { [weak self] in
            guard
                let self = self,
                let model = self.viewModel?.model as? RoversList
            else { return }
            let selectedRoverName = UserDefaults.standard.string(forKey: "chosen rover") ?? "Spirit"
            self.tableViewCells =
                model.rovers.compactMap {
                    RoverSelectionCellViewModel(cellType: RoverSelectionCell.self,
                                            name: $0.name,
                                            isSelected: $0.name == selectedRoverName)
                }
            self.tableView.reloadData()
        }
    }
    
    private func updateMaxDate(for rover: String) {
        guard
            let model = self.viewModel?.model as? RoversList,
            let newMaxDate = model.rovers.first(where: { $0.name == rover })?.maxDate
        else { return }
        UserDefaults.standard.set(newMaxDate, forKey: "date")
    }
    
    private func changeRover(at indexPath: IndexPath) {
        let newRoverPosition = indexPath.row
        guard
            let oldRoverName = UserDefaults.standard.string(forKey: "chosen rover"),
            let newRoverName = (tableViewCells[indexPath.row] as? RoverSelectionCellViewModel)?.name,
            let oldRoverPosition = (tableViewCells as? [RoverSelectionCellViewModel])?.firstIndex(where: {
                $0.name == oldRoverName
            }),
            newRoverPosition != oldRoverPosition
        else { return }
        let selectedRoverViewModel = RoverSelectionCellViewModel(cellType: RoverSelectionCell.self, name: newRoverName, isSelected: true)
        let unselectedRoverViewModel = RoverSelectionCellViewModel(cellType: RoverSelectionCell.self, name: oldRoverName, isSelected: false)
        tableViewCells[newRoverPosition] = selectedRoverViewModel
        tableViewCells[oldRoverPosition] = unselectedRoverViewModel
        UserDefaults.standard.set(newRoverName, forKey: "chosen rover")
        updateMaxDate(for: newRoverName)
        tableView.reloadRows(at: [IndexPath(row: newRoverPosition, section: 0)], with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: oldRoverPosition, section: 0)], with: .none)
    }
    
    override func setHeaderAndFooter() {
        tableView.tableHeaderView = TableViewSpacer(separatedFrom: .bottom)
        tableView.tableFooterView = TableViewSpacer(separatedFrom: .top)
        sizeHeaderToFit()
        sizeFooterToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        makeNavBarTextItems(title: "Марсоход", subtitle: "ВЫБИРАЕМ")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeRover(at: indexPath)
    }
}

