//
//  ViewController.swift
//  07-WhitehousePetitions
//
//  Created by Евгений Никитин on 05.11.2021.
//

import UIKit

class ViewController: UITableViewController {

    var petitions: [Petition] = []
    var filteredPetitions: [Petition] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        loadContent()
        setupCreditsButton()
        setupFilterButton()
    }
}


// MARK: Privates
extension ViewController {
    
    private func loadContent() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parseData(json: data)
                return
            }
        }
        showError()
    }
    
    private func parseData(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    private func setupCreditsButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(showCredits))
    }
            
    @objc private func showCredits() {
        let credits = "the data comes from the We The People API of the Whitehouse"
        
        let vc = UIAlertController(
            title: "Credits",
            message: credits,
            preferredStyle: .alert)
        
        vc.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil))
            
        present(vc, animated: true)
    }
    
    private func setupFilterButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(promptForAnswer))
    }
            
    @objc private func promptForAnswer() {
        let ac = UIAlertController(
            title: "Enter your word",
            message: "You should enter some word, otherwise you can reset the filter by submitting the empty field",
            preferredStyle: .alert
        )
        ac.addTextField()
        
        let submitAction = UIAlertAction(
            title: "Submit", style: .default) { [weak self, weak ac] _ in
                guard let answer = ac?.textFields?[0].text else { return }
                self?.filterPetitions(text: answer.lowercased())
            }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    private func filterPetitions(text: String) {
        if text != "" {
            filteredPetitions.removeAll()
            filteredPetitions = petitions.filter { $0.title.lowercased().contains(text) }
        } else {
            filteredPetitions = petitions
        }
        tableView.reloadData()
    }
    
    private func showError() {
        let ac = UIAlertController(
            title: "Loading error",
            message: "There was a problem loading the feed",
            preferredStyle: .alert
        )
        ac.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: nil
            ))
        present(ac, animated: true)
    }
}


// MARK: Table view methods
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
