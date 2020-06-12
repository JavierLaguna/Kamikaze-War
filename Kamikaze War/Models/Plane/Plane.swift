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
    var life: Int = 100
    var lifeBar: LifeBar
    
    init(withId id: Int, at position: SCNVector3, target: simd_float4x4?) {
        self.id = id
        self.lifeBar = LifeBar(at: SCNVector3(position.x, position.y + 0.2, position.z))
        
        super.init()
        
        let plane = SCNScene(named: "ship.scn") ?? SCNScene()
        let node = plane.rootNode
        self.addChildNode(node)
        
        // Añadimos físicas al avión
        let shape = SCNPhysicsShape(node: node, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        // Identificador de nuestro objecto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.plane.rawValue
        
        // Especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue
        
        // Posicionar el avión
        self.position = position
       
        
        // Animar el avión
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        let hoverForever = SCNAction.repeatForever(hoverSequence)
        self.runAction(hoverForever)
        lifeBar.runAction(hoverForever)

        if let columns = target?.columns {
            let vector = SCNVector3(columns.3.x, columns.3.y, columns.3.z)
            let moveToTarget = SCNAction.move(to: vector, duration: 10)
            lifeBar.runAction(moveToTarget)
            self.runAction(moveToTarget) {
                print("ACTION FINISH")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func face(to objectOrientation: simd_float4x4) {
        var transform = objectOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
        lifeBar.face(to: objectOrientation)
    }
    
    func destroy() {
        removeFromParentNode()
        lifeBar.destroy()
    }
}
