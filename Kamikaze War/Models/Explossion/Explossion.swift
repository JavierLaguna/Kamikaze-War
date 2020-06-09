//
//  Explossion.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

struct Explossion {
    
    static func show(with node: SCNNode, in scene: SCNScene) {
        let explossion = SCNParticleSystem(named: "Explossion", inDirectory: nil)!
        let p = node.position
        let translationMatrix = SCNMatrix4MakeTranslation(p.x, p.y, p.z)
        let r = node.rotation
        let rotationMatrix = SCNMatrix4MakeRotation(r.w, r.x, r.y, r.z)
        let transformMatrix = SCNMatrix4Mult(rotationMatrix, translationMatrix)
        explossion.emitterShape = node.geometry
        scene.addParticleSystem(explossion, transform: transformMatrix)
    }
}
