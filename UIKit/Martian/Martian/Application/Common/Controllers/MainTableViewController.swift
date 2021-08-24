//
//  MainTableViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class MainTableViewController: UITableViewController , TableViewControllerDesignable, ViewModelConnectable {
    
    var viewModel: ViewModel?
    var tableViewCells: [TableViewCellViewModel] = []
    
    func assignViewModel() { } //No need to call super
    
    func setStandartInteractionOptions() {
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    func setStandartDesign() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    
    func registerCells() { }
    
    func makeNavBarTextItems(title: String?, subtitle: String?) {
        navigationItem.title = title
        let label = UILabel()
        label.font = Header.small
        label.textColor = .lightGreen
        label.text = subtitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    func setHeaderAndFooter() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignViewModel()
        setStandartDesign()
        setStandartInteractionOptions()
        setHeaderAndFooter()
        setNavigationBar()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        (viewModel as? StandartViewModel)?.updateModel() {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        return tableViewCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = tableViewCells[indexPath.row]
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
