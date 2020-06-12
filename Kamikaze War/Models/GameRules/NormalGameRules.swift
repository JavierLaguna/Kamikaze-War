//
//  NormalGameRules.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 10/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct NormalGameRules: GameRules {
    var planesOnInit: Int = 2
    var maxPlanesOnScreen: Int = 4
    var ammoBoxesOnInit: Int = 2
    var maxAmmoBoxesOnScreen: Int = 3
    var bulletDamage: Int = 25
    var pointsForPlaneDesctruction: Int = 8
    var bulletsForAmmoBox: Int = 10
}
