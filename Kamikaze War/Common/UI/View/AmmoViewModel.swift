//
//  AmmoViewModel.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 12/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol AmmoViewDelegate: class {
    
}

class AmmoViewModel {
    
    // MARK: Constants
    let bullet: Bullet
    let icon: UIImage
    let color: UIColor
    
    // MARK: Variables
    weak var viewDelegate: AmmoViewDelegate?
    var countText: String
    var isSelected: Bool = false
    
    // MARK: Lifecycle
    init(bullet: Bullet, isSelected: Bool = false) {
        self.bullet = bullet
        self.countText = bullet.infinite ? "∞" : "\(bullet.count ?? 0)"
        self.icon = bullet.bulletIcon
        self.color = bullet.bulletColor
        self.isSelected = isSelected
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        
    }
    
    // MARK: Private Functions
}
