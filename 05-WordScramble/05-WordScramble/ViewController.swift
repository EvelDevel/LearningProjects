//
//  ViewController.swift
//  05-WordScramble
//
//  Created by Евгений Никитин on 31.10.2021.
//

import UIKit

enum WordError {
    case notRecognized
    case alreadyUsed
    case notPossible
}

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: Main setups
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(restartGame))
    }
}


// MARK: Game logic
extension ViewController {
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    
                    usedWords.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    showAlert(type: .notRecognized)
                }
            } else {
                showAlert(type: .alreadyUsed)
            }
        } else {
            showAlert(type: .notPossible)
        }
    }
    
    /// Can we, or can't we make a word from start word
    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {
            return false
        }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// Doesn't contains in used words array
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    /// Does this word exist or not
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}


// MARK: Table delegates
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}


// MARK: Helper methods
extension ViewController {
    
    private func showAlert(type: WordError) {
        let errorTitle: String
        let errorMessage: String
        
        switch type {
        case .notRecognized:
            errorTitle = "Word not recognized"
            errorMessage = "You can't just make them up"
        case .alreadyUsed:
            errorTitle = "Word already used"
            errorMessage = "Be more original"
        case .notPossible:
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title!.lowercased())"
        }
        
        let ac = UIAlertController(
            title: errorTitle,
            message: errorMessage,
            preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(
            title: "Ok",
            style: .default))
        
        present(ac, animated: true)
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
    
    @objc private func restartGame() {
        findWords()
    }
}
