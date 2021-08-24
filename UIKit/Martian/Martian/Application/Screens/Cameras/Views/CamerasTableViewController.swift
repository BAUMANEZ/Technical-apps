//
//  CamerasTableViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

class CamerasTableViewController: MainTableViewController {
    var selectedRoverName: String {
        return UserDefaults.standard.string(forKey: "chosen rover") ?? "Spirit"
    }
    
    var selectedDate: String? {
        return nil
    }
    
    override func registerCells() {
        tableView.register(CameraCell.self, forCellReuseIdentifier: "CameraCell")
    }
    
    func makeNavBarButtons() {
        let next = UIBarButtonItem(image: UIImage(named: "rightArrow"), style: .plain, target: self, action: nil)
        let previous = UIBarButtonItem(image: UIImage(named: "leftArrow"), style: .plain, target: self, action: nil)
        next.tintColor = .primary
        previous.tintColor = .primary
        navigationItem.rightBarButtonItems = [next, previous]
    }
    
    override func assignViewModel() {
        viewModel = CamerasViewModel()
        viewModel?.bindViewModelToView = { [weak self] in
            guard
                let self = self,
                let photos = (self.viewModel?.model as? PhotosList)?.photos
            else { return }
            let cameraNames = photos.map { $0.camera.name }.uniqued()
            self.tableViewCells = cameraNames.map { cameraName in
                let photosFromTheCamera = photos.filter { photo in
                    cameraName == photo.camera.name
                }.map {
                    PhotoCellViewModell(cellType: PhotoCell.self,
                                        imageURL: $0.imageSource,
                                        title: "id #\($0.id)",
                                        subtitle: "SOL #\($0.sol)")
                }
                return CameraCellViewModel(cellType: CameraCell.self,
                                           cameraName: cameraName,
                                           photos: photosFromTheCamera)
            }
            self.tableView.reloadData()
        }
    }
    
    override func setStandartDesign() {
        super.setStandartDesign()
        tableView.separatorStyle = .none
    }
    
    override func setHeaderAndFooter() {
        tableView.tableHeaderView = TableViewSpacer()
        tableView.tableFooterView = TableViewSpacer()
        sizeHeaderToFit()
        sizeFooterToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeNavBarTextItems(title: selectedRoverName, subtitle: selectedDate)
    }
}
