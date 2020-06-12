//
//  GameRules.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 10/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol GameRules {
    var planesOnInit: Int { get }
    var maxPlanesOnScreen: Int { get }
    var ammoBoxesOnInit: Int { get }
    var maxAmmoBoxesOnScreen: Int { get }
    var bulletDamage: Float { get }
    var pointsForPlaneDesctruction: Int { get }
    var bulletsForAmmoBox: Int { get }
    var proBulletsOnInit: Int { get }
}
