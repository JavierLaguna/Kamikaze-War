//
//  Bullet.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class BasicBullet: SCNNode, Bullet {
   
    var velocity: Float = 9
    var bulletNode: SCNSphere = SCNSphere(radius: 0.02)
    var bulletColor: UIColor = .red
}
