//
//  HighScoreUserDefaultsRepository.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 14/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct HighScoreUserDefaultsRepository: HighScoreRepository {
    
    // MARK: UserDefaults keys
    private let highScoreKey = "UD_HighScoreKey"
    
    // MARK: HighScoreRepository
    
    func getHighScore() -> Int {
        UserDefaults.standard.value(forKey: highScoreKey) as? Int ?? 0
    }
    
    func setHighScore(_ highScore: Int) {
        UserDefaults.standard.set(highScore, forKey: highScoreKey)
    }
    
    func resetHighScore() {
        setHighScore(0)
    }
}
