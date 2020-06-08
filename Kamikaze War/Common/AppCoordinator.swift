//
//  AppCoordinator.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 08/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    // MARK: Repositories Injection
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let gameCoordinator = GameCoordinator()
        addChildCoordinator(gameCoordinator)
        gameCoordinator.start()
        
        window.rootViewController = gameCoordinator.presenter
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}
