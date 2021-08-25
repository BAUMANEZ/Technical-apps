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
    
    let leftItemLabel: UILabel = {
        let label = UILabel()
        label.font = Header.standart
        label.textColor = .lightGreen
        return label
    }()
    
    func assignViewModel() { } //No need to call super
    
    func setStandartInteractionOptions() { }
    
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
        leftItemLabel.text = subtitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItemLabel)
    }
    
    func setHeaderAndFooter() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStandartDesign()
        setStandartInteractionOptions()
        setHeaderAndFooter()
        setNavigationBar()
        registerCells()
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
        (cell as? Delegatable)?.delegate = self
        cell.setViewModel(cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        assignViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainTableViewController: CellDelegate {
    
}
