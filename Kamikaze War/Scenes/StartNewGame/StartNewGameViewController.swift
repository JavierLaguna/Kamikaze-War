//
//  StartNewGameViewController.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 08/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class StartNewGameViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var scoreLabel: UILabel!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    // MARK: Private functions
    private func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: IBActions
    @IBAction private func tapStartNewGameButton(_ sender: Any) {
    }
}
