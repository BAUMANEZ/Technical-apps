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
    
    var selectedDate: Date!
    
    override func registerCells() {
        tableView.register(PhotosCollectionCell.self, forCellReuseIdentifier: "PhotosCollectionCell")
        tableView.register(CameraNameCell.self, forCellReuseIdentifier: "CameraNameCell")
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
            self.tableViewCells.removeAll()
            let cameraNames = photos.map { $0.camera.name }.uniqued()
            cameraNames.forEach { cameraName in
                //HEADER OF A CELL
                self.tableViewCells.append(
                    CameraNameCellViewModel(cellType: CameraNameCell.self,
                                            cameraName: cameraName)
                )

                //CONTENT OF A CELL
                let photosFromTheCamera = photos.filter { photo in
                    cameraName == photo.camera.name
                }.map {
                    PhotoCellViewModel(cellType: PhotoCell.self,
                                        imageURL: $0.imageSource,
                                        title: "ID #\($0.id)",
                                        subtitle: "СОЛ #\($0.sol)")
                }
                self.tableViewCells += [
                    PhotosCollectionCellViewModel(cellType: PhotosCollectionCell.self,
                                                  photos: photosFromTheCamera)
                ]
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
        makeNavBarTextItems(title: selectedRoverName, subtitle: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        (viewModel as? CamerasViewModel)?.update()
    }
}

extension CamerasTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableViewCells[indexPath.row].cellType {
        case is CameraNameCell.Type:
            return .cameraNameCellHeight
        case is PhotosCollectionCell.Type:
            return .photoCellHeight
        default:
            return 0
        }
    }
}
