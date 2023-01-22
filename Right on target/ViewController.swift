//
//  ViewController.swift
//  Right on target
//
//  Created by Apple M1 on 01.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    @IBOutlet var roundNum: UILabel!
    @IBOutlet var button: UIButton!
    
    var game: Game!
    
    // - Жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // Cоздаем экземпляр сущности игра
        game = Game(startValue: 1, endValue: 50, rounds: 5)
        
        // Обновляем данные о текущем значении загаданного числа
        updateSecretValueOnLabel(newText: String(game.currentSecretValue))
    }
    
    // - Взаимодействие View и Model

    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        game.calculateScore(with: Int(slider.value))
        
        // Проверяем окончена ли игра
        if game.isGameEnded {
            showAlertEndGame(score: game.score)
            game.restartGame()
        }
        else {
            showAlertRound(score: game.roundScore, round: game.currentRound)
            game.startNewRound()
        }
        
        // Обновляем данные о текущем значении загаданного числа
        updateSecretValueOnLabel(newText: String(game.currentSecretValue))
    }
    
    // - Обновление View
    
    // Обновление текста загаданного числа
    private func updateSecretValueOnLabel(newText: String) {
        // передаем значение случайного числа в label
        label.text = newText
        // отображаем номер раунда
        roundNum.text = String(game.currentRound)
    }
    
    // Отображение всплывающего окна со счетом
    private func showAlertEndGame(score: Int) {
        let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков из 250 возможных!",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertRound(score: Int, round: Int) {
        let alert = UIAlertController(
            title: "Итоги раундоа №\(round):",
            message: "Вы заработали \(score) очков! Вы поставили ползунок на число \(Int(slider.value))",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Далее", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

