//
//  MainTableViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class MainTableViewController: UITableViewController , TableViewControllerDesignable {
    
    var displayCells: [[CellViewModel]] = []
    
    func setStandartInteractionOptions() {
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func setStandartDesign() {
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func registerCells() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStandartDesign()
        setStandartInteractionOptions()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return displayCells.count
    }
    
    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        guard section < displayCells.count else { return 0 }
        return displayCells[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = displayCells[indexPath.section][indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(cellViewModel.cellType)", for: indexPath) as? TableViewRepresentable
        else {
            return UITableViewCell()
        }
        cell.setViewModel(cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
