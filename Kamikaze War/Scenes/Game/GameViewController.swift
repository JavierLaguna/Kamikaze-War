//
//  GameViewController.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import ARKit

class GameViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var sceneView: ARSCNView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var bulletsStack: UIStackView!
    
    var planes: [Plane] = [] // TODO DELETE
    let startPlanes = 5 // TODO DELETE
    
    // MARK: Constants
    private let viewModel: GameViewModel
    private let configuration = ARWorldTrackingConfiguration()
    
    // MARK: Lifecycle
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        addGestures()
        showBulletTypes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWasLoaded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        sceneView.session.pause()
    }
    
    // MARK: Private Functions
    private func setupComponents() {
        sceneView.session.run(configuration)
        sceneView.session.delegate = self
        
        // tenemos que indicar que se nos avise cuando haya un contacto
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        view.addGestureRecognizer(tap)
    }
    
    
    
    private func showBulletTypes() {
        let b = AmmoView()
        b.load(text: "100", image: UIImage(named: "ic_pro_bullet"))
        
        bulletsStack.addArrangedSubview(b)
        
        let a = AmmoView()
        a.load(text: "∞", image: UIImage(named: "ic_basic_bullet"))
        
        bulletsStack.addArrangedSubview(a)
        
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
    
    private func exitGame() {
        viewModel.exitGame()
    }
    
    private func resumeGame() {
        sceneView.session.run(configuration)
    }
    
    // MARK: IBActions
    @IBAction private func tapExitButton(_ sender: Any) {
        sceneView.session.pause()
        
        let exitAction = UIAlertAction(title: "Exit", style: .destructive, handler: { [weak self] _ in
            self?.exitGame()
        })
        let continueAction = UIAlertAction(title: "Continue", style: .cancel, handler: { [weak self] _ in
            self?.resumeGame()
        })
        
        let alert = UIAlertController(title: "Do you want exit?", message: "Your current score will not save", preferredStyle: .alert)
        alert.addAction(exitAction)
        alert.addAction(continueAction)
        
        self.present(alert, animated: true)
    }
}

//MARK: - GameViewDelegate
extension GameViewController: GameViewDelegate {
    
    func planeAdded(_ plane: Plane) {
        sceneView.prepare([plane]) { [weak self] _ in
            self?.sceneView.scene.rootNode.addChildNode(plane)
        }
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
            
            // cargamos un nuevo avión // TODO
            //            self.addNewPlane(withId: id)
            
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
