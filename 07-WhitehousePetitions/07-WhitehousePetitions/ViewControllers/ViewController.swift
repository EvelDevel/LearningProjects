//
//  ViewController.swift
//  07-WhitehousePetitions
//
//  Created by Евгений Никитин on 05.11.2021.
//

import UIKit

class ViewController: UITableViewController {

    var petitions: [Petition] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: Privates
extension ViewController {
    
    private func setup() {
        loadContent()
    }
    
    private func loadContent() {
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parseData(json: data)
            }
        }
    }
    
    private func parseData(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
}


// MARK: Table view methods
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
}
