//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denis Bystruev on 02/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.width < size.height {
            topStackView.axis = .vertical
        } else {
            topStackView.axis = .horizontal
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
    }
}

