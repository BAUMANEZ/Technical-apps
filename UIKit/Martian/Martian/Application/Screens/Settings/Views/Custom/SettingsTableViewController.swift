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
            UserDefaults.standard.set(selectedRoverName, forKey: "chosen rover")
            self.displayCells =
                model.rovers.compactMap {
                    RoverSelectionViewModel(cellType: RoverSelectionCell.self,
                                            name: $0.name,
                                            isSelected: $0.name == selectedRoverName)
                }
            self.tableView.reloadData()
        }
    }
    
    func setHeaderAndFooter() {
        tableView.tableHeaderView = TableViewSpacer(separatedFrom: .bottom)
        tableView.tableFooterView = TableViewSpacer(separatedFrom: .top)
        sizeHeaderToFit()
        sizeFooterToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignViewModel()
        makeNavBarTextItems(title: "Марсоход", subtitle: "ВЫБИРАЕМ")
        setHeaderAndFooter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        (viewModel as? SettingsViewModel)?.updateModel() {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newRoverPosition = indexPath.row
        guard
            let oldRoverName = UserDefaults.standard.string(forKey: "chosen rover"),
            let newRoverName = (displayCells[indexPath.row] as? RoverSelectionViewModel)?.name,
            let oldRoverPosition = (displayCells as? [RoverSelectionViewModel])?.firstIndex(where: {
                $0.name == oldRoverName
            }),
            newRoverPosition != oldRoverPosition
        else { return }
        let selectedRoverViewModel = RoverSelectionViewModel(cellType: RoverSelectionCell.self, name: newRoverName, isSelected: true)
        let unselectedRoverViewModel = RoverSelectionViewModel(cellType: RoverSelectionCell.self, name: oldRoverName, isSelected: false)
        displayCells[newRoverPosition] = selectedRoverViewModel
        displayCells[oldRoverPosition] = unselectedRoverViewModel
        UserDefaults.standard.set(newRoverName, forKey: "chosen rover")
        tableView.reloadRows(at: [IndexPath(row: newRoverPosition, section: 0)], with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: oldRoverPosition, section: 0)], with: .none)
    }
}

