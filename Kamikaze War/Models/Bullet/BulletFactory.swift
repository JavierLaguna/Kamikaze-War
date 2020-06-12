//
//  BulletFactory.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 12/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct BulletFactory {
    let gameRules: GameRules
    
    func getBullets() -> [Bullet] {
        return [
            getProBullet(),
            getBasicBullet()
        ]
    }
    
    private func getBasicBullet() -> Bullet {
        return BasicBullet(velocity: 9, damage: gameRules.bulletDamage, infinite: true, isSelected: true)
    }
    
    private func getProBullet() -> Bullet {
        return ProBullet(velocity: 12, damage: gameRules.bulletDamage * 2, infinite: false, count: gameRules.proBulletsOnInit)
    }
}
