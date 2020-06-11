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
    func showExplosion(on node: SCNNode)
}

class GameViewModel {
    
    // MARK: Constants
    let gameRules: GameRules
    
    // MARK: Variables
    weak var coordinatorDelegate: GameCoordinatorDelegate?
    weak var viewDelegate: GameViewDelegate?
    var planes: [Plane] = []
    var ammoBoxes: [AmmoBox] = []
    var cameraOrientation: simd_float4x4?
    
    // MARK: Lifecycle
    init(gameRules: GameRules) {
        self.gameRules = gameRules
    }
    
    // MARK: Public Functions
    func viewWasLoaded(cameraOrientation: simd_float4x4?) {
        self.cameraOrientation = cameraOrientation
        startGame()
    }
    
    func exitGame() {
        coordinatorDelegate?.gameDidFinish()
    }
    
    func planeBeaten(_ plane: Plane, node: SCNNode) {
        // TODO ADD DAMAGE LOGIC
        planes = planes.filter { $0.id != plane.id }
        plane.removeFromParentNode()
        viewDelegate?.showExplosion(on: node)
        addNewPlane(withId: plane.id)
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
        let plane = Plane(withId: id, target: cameraOrientation)
        planes.append(plane)

        let x = CGFloat.random(in: -2.5 ... 2.5)
        let y = CGFloat.random(in: -1.5 ... 1.5)
        let z = CGFloat.random(in: -4.5 ... -1)
        plane.position = SCNVector3(x, y, z)
    
        viewDelegate?.planeAdded(plane)
    }
}
