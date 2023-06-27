//
//  ColorViewController.swift
//  Right on target
//
//  Created by Apple M1 on 27.06.2023.
//

import UIKit

class ColorViewController: UIViewController {
    var currentColor: UIColor = .systemIndigo
    var completionHandler: ((UIColor) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setColorDefault() {
        self.currentColor = .systemIndigo
    }
    
    @IBAction func setColorBlue() {
        self.currentColor = .systemBlue
    }
    
    @IBAction func setColorPurple() {
        self.currentColor = .systemPurple
    }
    
    @IBAction func setColorGreen() {
        self.currentColor = .systemGreen
    }
    
    @IBAction func setColorWhite() {
        self.currentColor = .white
    }
    
    @IBAction func hideCurrentScene() {
        completionHandler?(currentColor)
        self.dismiss(animated: true)
    }
}
