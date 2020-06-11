//
//  GameViewModel.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 10/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit
import ARKit

protocol GameCoordinatorDelegate: class {
    func gameDidFinish()
}

protocol GameViewDelegate: class {
    func planeAdded(_ plane: Plane)
}

class GameViewModel {
    
    // MARK: Constants
    let gameRules: GameRules
    
    // MARK: Variables
    weak var coordinatorDelegate: GameCoordinatorDelegate?
    weak var viewDelegate: GameViewDelegate?
    var planes: [Plane] = []
    var ammoBoxes: [AmmoBox] = []
    
    // MARK: Lifecycle
    init(gameRules: GameRules) {
        self.gameRules = gameRules
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        startGame()
    }
    
    func exitGame() {
        coordinatorDelegate?.gameDidFinish()
    }
    
    // MARK: Private Functions
    private func startGame() {
        showInitialPlanes()
        //              addAmmoBox()
    }
    
    private func showInitialPlanes() {
        for index in 0..<gameRules.planesOnInit {
            addNewPlane(withId: index)
        }
    }
    
    private func addNewPlane(withId id: Int) {
        let plane = Plane(withId: id)
        planes.append(plane)

        let x = CGFloat.random(in: -2.5 ... 2.5)
        let y = CGFloat.random(in: -1.5 ... 1.5)
        let z = CGFloat.random(in: -4.5 ... -1)
        plane.position = SCNVector3(x, y, z)
    
        viewDelegate?.planeAdded(plane)
    }
}
