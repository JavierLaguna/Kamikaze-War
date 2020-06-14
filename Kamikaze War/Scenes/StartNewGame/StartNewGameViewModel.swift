//
//  StartNewGameViewModel.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol NewGameCoordinatorDelegate: class {
    func startGame(gameMode: GameLevelMode)
}

protocol NewGameViewDelegate: class {
    func scoreFetched()
}

class StartNewGameViewModel {
    
    // MARK: Constants
    private let highScoreRepository: HighScoreRepository
    
    // MARK: Variables
    weak var coordinatorDelegate: NewGameCoordinatorDelegate?
    weak var viewDelegate: NewGameViewDelegate?
    var highScore: Int = 0
    
    
    // MARK: Lifecycle
    init(highScoreRepository: HighScoreRepository) {
        self.highScoreRepository = highScoreRepository
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        getHighScore()
    }
    
    func startNewGame(hardIsOn: Bool) {
        let gameMode: GameLevelMode = hardIsOn ? .hard : .normal
        
        coordinatorDelegate?.startGame(gameMode: gameMode)
    }
    
    // MARK: Private Functions
    private func getHighScore() {
        highScore = highScoreRepository.getHighScore()
        viewDelegate?.scoreFetched()
    }
}
