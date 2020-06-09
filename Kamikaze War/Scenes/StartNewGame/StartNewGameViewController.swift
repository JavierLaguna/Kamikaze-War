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
    
    // MARK: Constants
    private let viewModel: StartNewGameViewModel
    
    // MARK: Lifecycle
    init(viewModel: StartNewGameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.startNewGame()
    }
}
