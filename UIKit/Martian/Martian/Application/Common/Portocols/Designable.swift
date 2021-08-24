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
    }
    
    func setStandartDesign() {
        view.backgroundColor = .systemBackground
    }
}


// MARK: - Cell Relative protocols
protocol CellRegistable {
    func registerCells()
}

protocol Interactive {
    func setStandartInteractionOptions()
}

//MARK: - Table View Controller Protocols
protocol TableViewDesignable: CellRegistable, Interactive {}
protocol TableViewCellDisplayable {
    var tableViewCells: [TableViewCellViewModel] { get set }
}

protocol TableViewControllerDesignable: ViewControllerDesignable, TableViewDesignable { }


//MARK: - Collection View Controller Protocols
protocol CollectionViewDesignable: CellRegistable, Interactive { }
protocol CollectionViewCellDisplayable {
    var collectionViewCells: [CollectionViewCellViewModel] { get set }
}

protocol CollectionViewControllerDesignable: ViewControllerDesignable, CollectionViewDesignable, CollectionViewCellDisplayable { }
