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
    
    var finished = false
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

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
    
    func enable(view: UIView, isEnabled: Bool) {
        if let button = view as? UIButton {
            button.isEnabled = isEnabled
        }
        
        for subview in view.subviews {
            enable(view: subview, isEnabled: isEnabled)
        }
    }
    
    func newRound() {
        let count = Game.listOfWords.count
        
        guard 0 < count else {
            correctWordLabel.text = "Игра окончена"
            
            enable(view: view, isEnabled: false)
            
            finished = true
            
            return
        }
        
        enable(view: view, isEnabled: true)
        
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
        guard !finished else { return }
        
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        
        treeImageView.image = image
        
        correctWordLabel.text = currentGame.correctWord
        
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.correctWord == currentGame.word.lowercased() {
            totalWins += 1
        }
        updateUI()
    }
    
    // MARK: - ... IBAction
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letter = sender.title(for: .normal)!
        
        currentGame.guess(letter: letter)
        
        updateGameState()
    }
}

