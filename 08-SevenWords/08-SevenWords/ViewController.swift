//
//  ViewController.swift
//  08-SevenWords
//
//  Created by Евгений Никитин on 06.11.2021.
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

