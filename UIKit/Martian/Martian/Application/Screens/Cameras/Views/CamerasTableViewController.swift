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
    
    override func registerCells() {
        tableView.register(PhotosCollectionCell.self, forCellReuseIdentifier: "PhotosCollectionCell")
        tableView.register(CameraNameCell.self, forCellReuseIdentifier: "CameraNameCell")
    }
    
    func makeNavBarButtons() {
        let next = UIBarButtonItem(image: UIImage(named: "rightArrow"), style: .plain, target: self, action: #selector(showNextDay))
        let previous = UIBarButtonItem(image: UIImage(named: "leftArrow"), style: .plain, target: self, action: #selector(showPreviousDay))
        next.tintColor = .primary
        previous.tintColor = .primary
        navigationItem.rightBarButtonItems = [next, previous]
    }
    
    @objc func showNextDay() {
        (viewModel as? CamerasViewModel)?.switchDate(.next)
    }
    
    @objc func showPreviousDay() {
        (viewModel as? CamerasViewModel)?.switchDate(.previous)
    }
    
    override func assignViewModel() {
        viewModel = CamerasViewModel()
        viewModel?.bindViewModelToView = { [weak self] in
            guard
                let self = self,
                let camerasViewModel = self.viewModel as? CamerasViewModel,
                let photos = (camerasViewModel.model as? PhotosList)?.photos,
                let date = camerasViewModel.date
            else { return }
            camerasViewModel.loadDate()
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
                                       imageScaleMode: .small,
                                       title: "id #\($0.id)",
                                       subtitle: "СОЛ #\($0.sol)")
                }
                self.tableViewCells += [
                    PhotosCollectionCellViewModel(cellType: PhotosCollectionCell.self,
                                                  photos: photosFromTheCamera)
                ]
            }
            self.leftItemLabel.text = DateFormatter().string(from: date, format: "dd.MM.yy")
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
        makeNavBarTextItems(title: selectedRoverName, subtitle: "Loading...")
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
            return .photoCellSmallHeight
        default:
            return 0
        }
    }
    
}

extension CamerasTableViewController: CameraNameCellDelegate {
    func didTapCamera(with name: String?) {
        //Extracting photos
        guard
            let indexOfCameraNameSection = tableViewCells.firstIndex(where: {($0 as? CameraNameCellViewModel)?.cameraName == name}),
            let photoCellViewModels = (tableViewCells[indexOfCameraNameSection + 1] as? PhotosCollectionCellViewModel)?.photos
        else { return }
        let photosCollectionViewController = PhotosCollectionViewController()
        photosCollectionViewController.collectionViewCells = photoCellViewModels.map {
            PhotoCellViewModel(cellType: $0.cellType,
                               imageURL: $0.imageURL,
                               imageScaleMode: .big,
                               title: $0.title,
                               subtitle: $0.subtitle)
        }
        
        navigationController?.pushViewController(photosCollectionViewController, animated: true)
    }
}
