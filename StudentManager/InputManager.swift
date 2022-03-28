//  InputManager.swift
//  StudentManager
//  Created by Daniel Garcia on 28/03/22.

import Foundation

struct InputManager {
    
    func getIntWith(_ message: String, errorMessage: String, withRange range: ClosedRange<Int>) -> Int {
        var isCorrect = false
        var number = 0
        repeat {
            if let value = Int(getStringWith(message, errorMessage: errorMessage)), range.contains(value) {
                number = value
                isCorrect = true
            } else {
                self.showErrorMessage(errorMessage)
            }
        } while !isCorrect
        return number
    }
    
    func getStringWith(_ message: String, errorMessage: String, withRange range: ClosedRange<Int>? = nil) -> String {
        var input = ""
        var isCorrect = false
        repeat {
            print(message)
            if let inputValue = readLine(), inputValue.count > 0 {
                input = inputValue
                isCorrect = range?.contains(inputValue.count) ?? true
            }
            if !isCorrect {
                self.showErrorMessage(errorMessage)
            }
        } while !isCorrect
        return input
    }

    private func showErrorMessage(_ errorMessage: String) {
        let message = """
        
        
        ************************************************
        ¡ERROR! - \(errorMessage)
        ************************************************
        
        
        """
        print(message)
    }
}
