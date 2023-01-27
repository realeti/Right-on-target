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
    
    // Количество заработанных очков за раунд
    var roundScore: Int { get }
    
    // Загаданное значение
    var currentSecretValue: Int { get }
    
    // Проверяем, закончена ли игра
    var isGameEnded: Bool { get }
    
    // Начинаем новую игру с первого раунда
    func restartGame()
    
    // Начинаем новый раунд (обновляем загаданное число)
    func startNewRound()
    
    // Сравниваем переданное значние с загаданным и начисляем очки
    func calculateScore(with value: Int)
}

class Game: GameProtocol {
    var score: Int = 0
    var roundScore: Int = 0
    var currentSecretValue: Int = 0
    
    // Минимальное и максимальное загаданное значение
    private var minSecretValue: Int
    private var maxSecretValue: Int
    
    // Количество раундов
    private var lastRound: Int
    var currentRound: Int = 1
    
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        }
        
        return false
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        // Стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentSecretValue = self.getNewSecretValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentSecretValue = self.getNewSecretValue()
        currentRound += 1
    }
    
    // Загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
    
    // Подсчитывает количество очков
    func calculateScore(with value: Int) {
        roundScore = 0
        
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
            roundScore += 50 - value + currentSecretValue
        }
        else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
            roundScore += 50 - currentSecretValue + value
        }
        else {
            score += 50
            roundScore += 50
        }
    }
}
