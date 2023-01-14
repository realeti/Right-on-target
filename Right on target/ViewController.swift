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
    
    // загаданное число
    var number: Int = 0
    
    // раунд
    var round: Int = 1
    
    // максимальное число раундов
    let roundMax: Int = 5

    // сумма очков за раунд
    var points: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // генерируем случайное число и передаем значение случайного числа в label
        generateNewRound()
    }

    @IBAction func checkNumber() {
    // если игра только начинается
    // получаем значение на слайдере
        let numSlider = Int(self.slider.value.rounded())
        
        // сравниваем значение с загаданным и подсчитываем очки
        if numSlider > self.number {
            self.points += 50 - numSlider + self.number
        }
        else if numSlider < self.number {
            self.points += 50 - self.number + numSlider
        }
        else {
            self.points += 50
        }
        
        if self.round == roundMax {
            // выводим информационное окно с результатами игры
            let alert = UIAlertController(
                title: "Игра окончена",
                message: "Вы заработали \(self.points) очков из 250 возможных!",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            
            self.round = 1
            self.points = 0
            generateNewRound()
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(
                title: "Итоги раунда №\(round):",
                message: "Вы заработали \(self.points) очков! Вы поставили ползунок на число: \(numSlider)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Далее", style: .default, handler: {
                _ in
                self.round += 1
                self.generateNewRound()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    func generateNewRound() {
        // генерируем случайное число
        self.number = Int.random(in: 1...50)
        // передаем значение случайного числа в label
        self.label.text = String(self.number)
        // отображаем № раунда
        self.roundNum.text = String(self.round)
    }

}

