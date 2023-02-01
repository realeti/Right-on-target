//
//  GameRound.swift
//  Right on target
//
//  Created by Apple M1 on 31.01.2023.
//

import Foundation

protocol GameRoundProtocol {
    // Количество заработанных очков за раунд
    var roundScore: Int { get set }
    
    // Получаем текущий раунд
    var currentRound: Int { get set }
    
    // Начинаем новый раунд (обновляем загаданное число)
    func startNewRound(maxRounds: Int)
}

class GameRound: GameRoundProtocol {
    var roundScore: Int = 0
    var currentRound: Int = 0
    
    func startNewRound(maxRounds: Int) {
        if currentRound >= maxRounds {
            currentRound = 1
        }
        else {
            currentRound += 1
        }
    }
}
