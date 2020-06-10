//
//  ProBullet.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 10/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class ProBullet: SCNNode, Bullet {
   
    var velocity: Float = 12
    var bulletNode: SCNSphere = SCNSphere(radius: 0.03)
    var bulletColor: UIColor = .blue
}
