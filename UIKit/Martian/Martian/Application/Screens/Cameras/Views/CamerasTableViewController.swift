//
//  CamerasTableViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class CamerasTableViewController: MainTableViewController {
    var selectedRoverName: String {
        return UserDefaults.standard.string(forKey: "chosen rover")!
    }
    
    var selectedDate: String {
        let date = Date() // temporary
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func makeNavBarButtons() {
        let rightArrow = UIBarButtonItem(image: UIImage(named: "rightArrow"), style: .plain, target: self, action: nil)
        let leftArrow = UIBarButtonItem(image: UIImage(named: "leftArrow"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [rightArrow, leftArrow]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTextItems(title: selectedRoverName, subtitle: selectedDate)
        makeNavBarButtons()
    }
}
