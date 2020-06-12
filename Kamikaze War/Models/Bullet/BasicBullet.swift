//
//  Bullet.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class BasicBullet: SCNNode, Bullet {
    
    var velocity: Float
    var damage: Float
    var infinite: Bool
    var count: Int?
    var bulletNode: SCNSphere = SCNSphere(radius: 0.02)
    var bulletColor: UIColor = .red
    
    init(velocity: Float, damage: Float, infinite: Bool, count: Int? = nil) {
        self.velocity = velocity
        self.damage = damage
        self.infinite = infinite
        self.count = count
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
