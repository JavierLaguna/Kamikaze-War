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
    func bulletFired(_ bullet: Bullet)
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
    var selectedBullet: Bullet {
        return bullets.first(where: { $0.isSelected }) ?? bullets[0]
    }
    var ammoViewModels: [AmmoViewModel] {
        return bullets.map {
            return AmmoViewModel(bullet: $0)
        }
    }
    
    // MARK: Lifecycle
    init(gameRules: GameRules) {
        let bulletFactory = BulletFactory(gameRules: gameRules)
        
        self.bulletFactory = bulletFactory
        self.gameRules = gameRules
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
    
    func fire() {
        viewDelegate?.bulletFired(selectedBullet)
        update(bullet: selectedBullet, with: -1)
    }
    
    func planeBeaten(_ plane: Plane, node: SCNNode) {
        // TODO ADD DAMAGE LOGIC
        planes = planes.filter { $0.id != plane.id }
        plane.destroy()
        viewDelegate?.showExplosion(on: node)
        addNewPlane(withId: plane.id)
    }
    
    func ammoBoxBeaten(_ ammoBox: AmmoBox, node: SCNNode) {
        if let notInfiniteBullet = bullets.first(where: { !$0.infinite }) {
            update(bullet: notInfiniteBullet, with: gameRules.bulletsForAmmoBox)
        }
        
        ammoBoxes = ammoBoxes.filter { $0.id != ammoBox.id }
        ammoBox.destroy()
        viewDelegate?.showExplosion(on: node)
        addNewAmmoBox(withId: ammoBox.id)
    }
    
    func changeSelectedBulletTo(_ bullet: Bullet) {
        bullets = bullets.map { item in
            item.isSelected = bullet.id == item.id
            NotificationCenter.default.post(name: item.notificationsId, object: item)
            return item
        }
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
    
    private func update(bullet: Bullet, with count: Int) {
        if !bullet.infinite, let currentCount = bullet.count {
            bullet.count = currentCount + count
            
            if bullet.count == 0,
                let firstAvailableBullet = bullets.first(where: { $0.infinite || $0.count ?? 0 > 0 }) {
                changeSelectedBulletTo(firstAvailableBullet)
            }
            
            NotificationCenter.default.post(name: bullet.notificationsId, object: bullet)
        }
    }
}
