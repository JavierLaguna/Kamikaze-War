//
//  Bullet.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 10/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

protocol Bullet: SCNNode {
    var velocity: Float { get set }
    var damage: Float { get set }
    var infinite: Bool { get set }
    var count: Int? { get set }
    var bulletNode: SCNSphere { get }
    var bulletColor: UIColor { get }
    
    func fireFrom(_ camera: ARCamera)
}

extension Bullet {
    
    func fireFrom(_ camera: ARCamera) {
        
        let bullet = bulletNode
        let material = SCNMaterial()
        material.diffuse.contents = bulletColor
        bullet.materials = [material]
        self.geometry = bullet
        
        // Añadimos físicas a la bala
        let shape = SCNPhysicsShape(geometry: bullet, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        // Identificador de nuestro objecto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.bullet.rawValue
        
        // Especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.plane.rawValue
        
        // Aplicamos impulso a la bala
        let matrix = SCNMatrix4(camera.transform)
        // Vector de dirección (También lleva incluida la velocidad)
        let v = -self.velocity
        let dir = SCNVector3(v * matrix.m31, v * matrix.m32, v * matrix.m33)
        // Necesitamos un punto de origen
        let pos = SCNVector3(matrix.m41, matrix.m42, matrix.m43)
        
        self.physicsBody?.applyForce(dir, asImpulse: true)
        self.position = pos
        
    }
}
