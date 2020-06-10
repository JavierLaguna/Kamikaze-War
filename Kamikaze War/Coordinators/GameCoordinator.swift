//
//  GameCoordinator.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 08/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class GameCoordinator: Coordinator {
    
    // MARK: Constants
    
    // MARK: Variables
    
    // MARK: Lifecycle
    init() {
        super.init()
    }
    
    override func start() {
        let startNewGameViewModel = StartNewGameViewModel()
        let startNewGameViewController = StartNewGameViewController(viewModel: startNewGameViewModel)
        
//        startNewGameViewModel.viewDelegate = startNewGameViewController
        startNewGameViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(startNewGameViewController, animated: false)
    }
    
    override func finish() {
    }
    
    private func goToGame() {
        let gameViewController = GameViewController()
        
        presenter.pushViewController(gameViewController, animated: false)
    }
}

// MARK: NewGameCoordinatorDelegate
extension GameCoordinator: NewGameCoordinatorDelegate {
    
    func startGame() {
        goToGame()
    }
}
