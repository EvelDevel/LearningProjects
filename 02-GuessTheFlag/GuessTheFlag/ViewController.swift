//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Евгений Никитин on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCountries()
        addBorders()
        askQuestion(action: nil)
    }
    
    // MARK: Privates
    
    private func addCountries() {
        countries += [
            "estonia", "france", "germany",
            "ireland", "italy", "monaco",
            "nigeria", "poland", "russia",
            "spain", "uk", "us"
        ]
    }
    
    private func addBorders() {
        buttons.forEach { button in
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func askQuestion(action: UIAlertAction!) {
        
        if totalAnswered >= 10 {
            let ac = UIAlertController(
                title: "Restart game",
                message: "You answered for all 10 questions",
                preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(
                title: "Restart",
                style: .default,
                handler: restartGame))
            
            present(ac, animated: true)
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
            title = "Find: \(countries[correctAnswer].uppercased()), score: \(score)"
        }
    }
    
    private func restartGame(action: UIAlertAction!) {
        score = 0
        correctAnswer = 0
        totalAnswered = 0
        askQuestion(action: nil)
    }
    
    // MARK: Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        totalAnswered += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(
            title: title,
            message: "Your score is \(score)",
            preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(
            title: "Continue",
            style: .default,
            handler: askQuestion))
        
        present(ac, animated: true)
    }
}
