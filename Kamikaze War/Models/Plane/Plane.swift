//
//  Plane.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class Plane: SCNNode {
    
    var id: Int = 0
    
    init(withId id: Int) {
        super.init()
        
        self.id = id
        
        let plane = SCNScene(named: "ship.scn") ?? SCNScene()
        let node = plane.rootNode
        self.addChildNode(node)
        
        let lifeBox = SCNBox(width: 1, height: 0.01, length: 0.01, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        material.isDoubleSided = true
        lifeBox.materials = [material]
        self.geometry = lifeBox
        
        // Añadimos físicas al avión
        let shape = SCNPhysicsShape(node: node, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        // Identificador de nuestro objecto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.plane.rawValue
        
        // Especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue
        
        // Animar el avión
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        let hoverForever = SCNAction.repeatForever(hoverSequence)
        self.runAction(hoverForever)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func face(to objectOrientation: simd_float4x4) {
        var transform = objectOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }
}
