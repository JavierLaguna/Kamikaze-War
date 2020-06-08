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
        let startNewGameViewController = StartNewGameViewController()
        
        presenter.pushViewController(startNewGameViewController, animated: false)
    }
    
    override func finish() {
    }
}
