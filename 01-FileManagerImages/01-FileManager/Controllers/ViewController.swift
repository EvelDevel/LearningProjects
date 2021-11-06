//
//  ViewController.swift
//  FileManagerImages
//
//  Created by Евгений Никитин on 23.10.2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: Privates
extension ViewController {

    private func setup() {
        setupUI()
        loadImages()
    }
    
    private func setupUI() {
        title = "Dune"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped))
    }
    
    private func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("pic") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    @objc private func shareTapped() {
        let description = "Share our app"
        
        let vc = UIActivityViewController(
            activityItems: [description],
            applicationActivities: [])

        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}


// MARK: Delegates and Datasource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.total = pictures.count
            vc.position = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
