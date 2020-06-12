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
    func ammoBoxAdded(_ ammoBox: AmmoBox)
    func showExplosion(on node: SCNNode)
}

class GameViewModel {
    
    // MARK: Constants
    let gameRules: GameRules
    let bulletFactory: BulletFactory
    
    // MARK: Variables
    weak var coordinatorDelegate: GameCoordinatorDelegate?
    weak var viewDelegate: GameViewDelegate?
    var planes: [Plane] = []
    var ammoBoxes: [AmmoBox] = []
    var cameraOrientation: simd_float4x4?
    var bullets: [Bullet] = []
    var selectedBullet: Bullet
    var ammoViewModels: [AmmoViewModel] {
        return bullets.map {
            return AmmoViewModel(bullet: $0, isSelected: $0.id == selectedBullet.id)
        }
    }
    
    // MARK: Lifecycle
    init(gameRules: GameRules) {
        let bulletFactory = BulletFactory(gameRules: gameRules)
        
        self.bulletFactory = bulletFactory
        self.gameRules = gameRules
        self.selectedBullet = bulletFactory.getInitialBullet()
        self.bullets = bulletFactory.getBullets()
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
        plane.destroy()
        viewDelegate?.showExplosion(on: node)
        addNewPlane(withId: plane.id)
    }
    
    func ammoBoxBeaten(_ ammoBox: AmmoBox, node: SCNNode) {
        // TODO ADD BULLETs
        ammoBoxes = ammoBoxes.filter { $0.id != ammoBox.id }
        ammoBox.destroy()
        viewDelegate?.showExplosion(on: node)
        addNewAmmoBox(withId: ammoBox.id)
    }
    
    // MARK: Private Functions
    private func startGame() {
        showInitialPlanes()
        showInitialAmmoBoxes()
    }
    
    private func showInitialPlanes() {
        for index in 0..<gameRules.planesOnInit {
            addNewPlane(withId: index)
        }
    }
    
    private func showInitialAmmoBoxes() {
        for index in 0..<gameRules.ammoBoxesOnInit {
            addNewAmmoBox(withId: index)
        }
    }
    
    private func addNewAmmoBox(withId id: Int) {
        let ammoBox = AmmoBox(withId: 0)
        ammoBoxes.append(ammoBox)
        
        let x = CGFloat.random(in: -1.5...1.5)
        let y = CGFloat.random(in: -2...2)
        let z = CGFloat.random(in: -2 ... -1)
        ammoBox.position = SCNVector3(x, y, z)
        
        viewDelegate?.ammoBoxAdded(ammoBox)
    }
    
    private func addNewPlane(withId id: Int) {
        let x = CGFloat.random(in: -2.5 ... 2.5)
        let y = CGFloat.random(in: -1.5 ... 1.5)
        let z = CGFloat.random(in: -4.5 ... -1)
        let position = SCNVector3(x, y, z)
        
        let plane = Plane(withId: id, at: position, target: cameraOrientation)
        planes.append(plane)
        
        viewDelegate?.planeAdded(plane)
    }
}
