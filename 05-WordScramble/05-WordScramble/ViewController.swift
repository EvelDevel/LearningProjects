//
//  ViewController.swift
//  05-WordScramble
//
//  Created by Евгений Никитин on 31.10.2021.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: Private methods
extension ViewController {
    
    private func setup() {
        findWords()
        setupNavigationItems()
    }
    
    private func findWords() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
    }
    
    private func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(promptForAnswer))
    }
    
    @objc private func promptForAnswer() {
        let ac = UIAlertController(
            title: "Enter answer",
            message: nil,
            preferredStyle: .alert
        )
        ac.addTextField()
        
        let submitAction = UIAlertAction(
            title: "Submit", style: .default) { [weak self, weak ac] _ in
                guard let answer = ac?.textFields?[0].text else { return }
                self?.submit(answer)
            }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    private func submit(_ answer: String) {
        
    }
}


// MARK: Table view delegates
extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}
