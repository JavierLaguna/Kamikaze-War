//
//  AmmoBox.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class AmmoBox: SCNNode {
    
    var id: Int = 0
    
    init(withId id: Int) {
        super.init()
        
        self.id = id
        
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)

        let material = SCNMaterial()
        material.diffuse.contents = UIColor.purple
        material.isDoubleSided = true
        box.materials = [material]
        self.geometry = box
        
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        self.physicsBody?.categoryBitMask = Collisions.ammoBox.rawValue
        
        self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue
        
        let rotation = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 5)
        let hoverForever = SCNAction.repeatForever(rotation)
        self.runAction(hoverForever)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
