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
    private let highScoreRepository: HighScoreRepository
    
    // MARK: Lifecycle
    init(highScoreRepository: HighScoreRepository) {
        self.highScoreRepository = highScoreRepository
        super.init()
    }
    
    override func start() {
        let startNewGameViewModel = StartNewGameViewModel(highScoreRepository: highScoreRepository)
        let startNewGameViewController = StartNewGameViewController(viewModel: startNewGameViewModel)
        
        startNewGameViewModel.viewDelegate = startNewGameViewController
        startNewGameViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(startNewGameViewController, animated: false)
    }
    
    override func finish() {}
    
    private func goToGame() {
        let gameRules = NormalGameRules() // TODO: uses different types of dificult
        let gameViewModel = GameViewModel(highScoreRepository: highScoreRepository, gameRules: gameRules)
        let gameViewController = GameViewController(viewModel: gameViewModel)
        
        gameViewModel.viewDelegate = gameViewController
        gameViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(gameViewController, animated: false)
    }
}

// MARK: NewGameCoordinatorDelegate
extension GameCoordinator: NewGameCoordinatorDelegate {
    
    func startGame() {
        goToGame()
    }
}

// MARK: GameCoordinatorDelegate
extension GameCoordinator: GameCoordinatorDelegate {
    
    func gameDidFinish() {
        presenter.popViewController(animated: true)
    }
}
