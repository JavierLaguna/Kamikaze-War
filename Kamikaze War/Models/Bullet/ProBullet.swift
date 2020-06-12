//
//  ProBullet.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 10/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class ProBullet: SCNNode, Bullet {
   
    var id: String = "ProBullet"
    var velocity: Float
    var damage: Float
    var infinite: Bool
    var count: Int?
    var bulletIcon: UIImage = UIImage(named: "ic_pro_bullet") ?? UIImage()
    var bulletNode: SCNSphere = SCNSphere(radius: 0.03)
    var bulletColor: UIColor = .blue
    
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
