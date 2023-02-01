//
//  Game.swift
//  Right on target
//
//  Created by Apple M1 on 17.01.2023.
//

import UIKit

protocol GameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    // Загаданное значение
    var currentSecretValue: Int { get }
    // Проверяем, закончена ли игра
    var isGameEnded: Bool { get }
    
    // Обработчик раундов
    var gameRound: GameRoundProtocol! { get }
    // Генератор случайного значения
    var secretValueGenerator: GeneratorProtocol { get }
    
    // Начинаем новую игру с первого раунда
    func restartGame()
    // Сравниваем переданное значние с загаданным и начисляем очки
    func calculateScore(with value: Int)
}

class Game: GameProtocol {
    var score: Int = 0
    var currentSecretValue: Int = 0
    var currentRound: Int = 0
    var roundScore: Int = 0
    
    // Обработка раундов
    private var countRounds: Int
    var gameRound: GameRoundProtocol!
    
    // Генератор случайного числа
    var secretValueGenerator: GeneratorProtocol
    
    var isGameEnded: Bool {
        if gameRound.currentRound >= countRounds {
            return true
        }
        
        return false
    }
    
    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        gameRound = GameRound()
        secretValueGenerator = valueGenerator
        countRounds = rounds
        startNewRound()
        currentRound = gameRound.currentRound
    }
    
    func restartGame() {
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        gameRound.startNewRound(maxRounds: countRounds)
        currentSecretValue = self.getNewSecretValue()
        currentRound = gameRound.currentRound
    }
    
    private func getNewSecretValue() -> Int {
        return secretValueGenerator.getSecretValue()
    }
    
    //Подсчитывает количество очков
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
            gameRound.roundScore = 50 - value + currentSecretValue
            roundScore = gameRound.roundScore
        }
        else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
            gameRound.roundScore = 50 - currentSecretValue + value
            roundScore = gameRound.roundScore
        }
        else {
            score += 50
            gameRound.roundScore = 50
            roundScore = gameRound.roundScore
        }
    }
}
