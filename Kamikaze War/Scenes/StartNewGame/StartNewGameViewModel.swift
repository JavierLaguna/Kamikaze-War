//
//  StartNewGameViewModel.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol NewGameCoordinatorDelegate: class {
    func startGame()
}

protocol NewGameViewDelegate: class {
    func scoreFetched()
}

class StartNewGameViewModel {
    
    // MARK: Constants
    
    // MARK: Variables
    weak var coordinatorDelegate: NewGameCoordinatorDelegate?
    weak var viewDelegate: NewGameViewDelegate?
    
    
    // MARK: Lifecycle
    init() {
        
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        // TODO Get High Score
    }
    
    func startNewGame() {
        coordinatorDelegate?.startGame()
    }
    
    // MARK: Private Functions
    
}
