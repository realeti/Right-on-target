//
//  Generator.swift
//  Right on target
//
//  Created by Apple M1 on 31.01.2023.
//

import Foundation

protocol GeneratorProtocol {
    func getSecretValue() -> Int
}

class NumberGenerator: GeneratorProtocol {
    private let startRangeValue: Int
    private let endRangeValue: Int
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    func getSecretValue() -> Int {
        (startRangeValue...endRangeValue).randomElement()!
    }
}
