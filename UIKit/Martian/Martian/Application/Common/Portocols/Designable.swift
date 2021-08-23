//
//  Designable.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

//MARK: - View Controller Protocols
protocol ViewControllerDesignable: UIViewController {
    func setStandartDesign()
    func setNavigationBar()
}

extension ViewControllerDesignable  {
    func setNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .systemBackground
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor.primary,
            .font : Header.normal ?? UIFont.preferredFont(forTextStyle: .subheadline)
        ]
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor : UIColor.primary,
            .font : Header.big ?? UIFont.preferredFont(forTextStyle: .largeTitle)
        ]
        navigationItem.title = "Марсоходы"
    }
    
    func setStandartDesign() {
        view.backgroundColor = .systemBackground
    }
}


//MARK: - Table View Controller Protocols
protocol TableViewControllerDesignable: UITableViewController, ViewControllerDesignable {
    var displayCells: [[CellViewModel]] { get set }
    
    func setStandartInteractionOptions()
    func registerCells()
}
