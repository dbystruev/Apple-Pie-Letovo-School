//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denis Bystruev on 02/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - ... IBOutlet
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - ... Properties
    var currentGame: Game!
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0
    var totalLosses = 0

    // MARK: - ... Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.width < size.height {
            topStackView.axis = .vertical
        } else {
            topStackView.axis = .horizontal
        }
    }
    
    func newRound() {
        let count = Game.listOfWords.count
        let index: Int
        
        if count < 2 {
            index = 0
        } else {
            index = Int.random(in: 0 ..< count)
        }
        
        let newWord = Game.listOfWords.remove(at: index)
        
        currentGame = Game(
            word: newWord,
            incorrectMovesRemaining: incorrectMovesAllowed,
            guessedLetters: []
        )
        
        updateUI()
    }
    
    func updateUI() {
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        
        treeImageView.image = image
        
        correctWordLabel.text = currentGame.correctWord
        
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    
    // MARK: - ... IBAction
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letter = sender.title(for: .normal)!
        
        currentGame.guess(letter: letter)
    }
}

