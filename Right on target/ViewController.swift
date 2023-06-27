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
    var gameRound: GameRound!
    
    lazy var colorViewController: ColorViewController = getColorViewController()
    
    // - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // Создаем генератор случайных чисел
        let generator = NumberGenerator(startValue: 1, endValue: 50)!
        
        // Cоздаем обработчик раундов
        gameRound = GameRound()
        
        // Cоздаем экземпляр сущности игра
        game = Game(valueGenerator: generator, roundControl: gameRound, rounds: 5)
        
        // Обновляем данные о текущем значении загаданного числа
        updateSecretValueOnLabel(newSecretValue: String(game.currentSecretValue), round: String(gameRound.currentRound))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        self.view.backgroundColor = .systemIndigo
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDissapear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    // Переход к следующей сцене
    @IBAction func showNextScreen() {
        // Отображение сцены на экране
        self.present(colorViewController, animated: true, completion: nil)
    }
    
    private func getColorViewController() -> ColorViewController {
        // Загрузка story board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Загрузка View Controller и его сцены со StoryBoard
        let viewController = storyboard.instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        
        viewController.completionHandler = { [weak self] color in
            self?.view.backgroundColor = color
        }
        
        return viewController
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
            showAlertRound(score: gameRound.roundScore, round: gameRound.currentRound)
            game.startNewRound()
        }
        
        // Обновляем данные о текущем значении загаданного числа
        updateSecretValueOnLabel(newSecretValue: String(game.currentSecretValue), round: String(gameRound.currentRound))
    }
    
    // - Обновление View
    
    // Обновление текста загаданного числа
    private func updateSecretValueOnLabel(newSecretValue: String, round: String) {
        // передаем значение случайного числа в label
        label.text = newSecretValue
        // отображаем номер раунда
        roundNum.text = round
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
            title: "Итоги раунда №\(round):",
            message: "Вы заработали \(score) очков! Вы поставили ползунок на число \(Int(slider.value))",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Далее", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

