//
//  Collisions.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct Collisions: OptionSet {
    let rawValue: Int
    
    static let plane = Collisions(rawValue: 1 << 0)
    static let bullet = Collisions(rawValue: 1 << 1)
}
