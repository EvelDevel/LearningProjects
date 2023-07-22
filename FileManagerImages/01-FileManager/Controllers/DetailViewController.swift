//
//  DetailViewController.swift
//  FileManagerImages
//
//  Created by Евгений Никитин on 23.10.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    var total = 0
    var position = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}

// MARK: Privates
extension DetailViewController {
    
    private func setup() {
        loadImage()
        setupUI()
    }
    
    private func loadImage() {
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    private func setupUI() {
        title = "Picture \(position) of \(total)"
        navigationItem.largeTitleDisplayMode = .never
    }
}
