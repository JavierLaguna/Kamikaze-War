//
//  LifeBar.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 12/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class LifeBar: SCNNode {
    
    init(at position: SCNVector3) {
        super.init()
        
        let lifeBox = SCNBox(width: 1, height: 0.01, length: 0.01, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        material.isDoubleSided = true
        lifeBox.materials = [material]
        self.geometry = lifeBox
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func face(to objectOrientation: simd_float4x4) {
        var transform = objectOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }
    
    func destroy() {
        removeFromParentNode()
    }
}
