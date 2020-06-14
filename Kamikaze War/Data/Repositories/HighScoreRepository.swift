//
//  HighScoreRepository.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 14/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol HighScoreRepository {
    func getHighScore() -> Int
    func setHighScore(_ highScore: Int)
    func resetHighScore()
}
