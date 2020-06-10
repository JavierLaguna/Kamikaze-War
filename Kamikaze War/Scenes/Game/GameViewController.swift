//
//  GameViewController.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class GameViewController: UIViewController {
    
    @IBOutlet private weak var sceneView: ARSCNView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var bulletsStack: UIStackView!
    
    var planes: [Plane] = []
    let startPlanes = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        addGestures()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        sceneView.session.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for index in 0..<startPlanes {
            addNewPlane(withId: index)
        }
        addAmmoBox()
    }
    
    fileprivate func setupComponents() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        sceneView.session.delegate = self
        
        // tenemos que indicar que se nos avise cuando haya un contacto
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        view.addGestureRecognizer(tap)
    }
    
    private func addNewPlane(withId id: Int) {
        let plane = Plane(withId: id)
        let x = CGFloat.random(in: -1.5...1.5) // Un metro y medio a la izq o a la derecha
        let y = CGFloat.random(in: -2...2) // Dos metro arriba o abajo
        let z = CGFloat.random(in: -2 ... -1) // Profundidad
        
        plane.position = SCNVector3(x, y, z)
        self.planes.append(plane)
        
        self.sceneView.prepare([plane]) { _ in
            self.sceneView.scene.rootNode.addChildNode(plane)
        }
    }
    
    private func addAmmoBox() {
        let ammoBox = AmmoBox(withId: 0)
        let x = CGFloat.random(in: -1.5...1.5) // Un metro y medio a la izq o a la derecha
        let y = CGFloat.random(in: -2...2) // Dos metro arriba o abajo
        let z = CGFloat.random(in: -2 ... -1) // Profundidad
        
        ammoBox.position = SCNVector3(x, y, z)
//        self.planes.append(plane)
        
        self.sceneView.prepare([ammoBox]) { _ in
            self.sceneView.scene.rootNode.addChildNode(ammoBox)
        }
    }
    
    @objc private func tapScreen() {
        guard let camera = self.sceneView.session.currentFrame?.camera else {
            return
        }
        
        let bullet = ProBullet()
        bullet.fireFrom(camera)
        sceneView.scene.rootNode.addChildNode(bullet)
    }
    
    @IBAction private func tapExitButton(_ sender: Any) {
        // TODO:
    }
}

//MARK: - Contact delegate
extension GameViewController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // Si algo choca con el avión
        if contact.nodeA.physicsBody?.categoryBitMask == Collisions.plane.rawValue ||
            contact.nodeB.physicsBody?.categoryBitMask == Collisions.plane.rawValue {
            
            var node: SCNNode!
            var id: Int = 0
            if let plane = contact.nodeA as? Plane {
                node = contact.nodeA
                id = plane.id
            } else if let plane = contact.nodeB as? Plane {
                node = contact.nodeB
                id = plane.id
            }
            
            // Explosion
            Explossion.show(with: node, in: sceneView.scene)
            
            self.sceneView.scene.rootNode.childNodes.forEach { node in
                if let plane = node as? Plane, plane.id == id {
                    
                    plane.removeFromParentNode()
                    planes = planes.filter{ $0.id != id}
                    
                } else if let bullet = node as? Bullet {
                    
                    bullet.removeFromParentNode()
                }
            }
            
            // cargamos un nuevo avión
            self.addNewPlane(withId: id)
        }
    }
}

//MARK: - ARSCNViewDelegate
extension GameViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Billboard, que el avión siempre nos mire
        if let cameraOrientation = session.currentFrame?.camera.transform {
            self.planes.forEach { $0.face(to: cameraOrientation) }
        }
    }
}
