//
//  PhotoViewController.swift
//  Martian
//
//  Created by Арсений Токарев on 26.08.2021.
//

import UIKit

class PhotoViewController: UIViewController, ViewControllerDesignable {
    private let imageView = UIImageView()
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.pin(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStandartDesign()
        configureImageView()
    }
    
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
