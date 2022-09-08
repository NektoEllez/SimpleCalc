//
//  CalcService.swift
//  SimpleCalc
//
//  Created by Иван Марин on 08.09.2022.
//

import Foundation

class CalcService {
    // MARK: — Properties
    var isRunning = true
    var currentNumber: String = "0"
    var result: String = ""
    var currentOperation = Operations.noAction
    var firsNumber: Double = 0.0
    var secondNumber: Double = 0.0
    var displayView: ViewController
    
    init(displayView: ViewController) {
        self.displayView = displayView
    }
    
    // MARK: — Methods
    func updateDisplay(text: String) {
        print(text)
    }
    
    func makeCalculation(operations: Operations) {
        if currentOperation != .noAction {
            currentNumberIsNotEmpty(operations: operations)
        } else {
            guard let currentNumberDouble = Double(currentNumber) else { return }
            firsNumber = currentNumberDouble
            currentNumber = ""
            updateDisplay(text: currentNumber)
            currentOperation = operations
        }
        print(
        """
        \
        -------------------------------------------
        current number  = \(currentNumber)
        first           = \(firsNumber)
        second          = \(secondNumber)
        result          = \(result)
        -------------------------------------------
        \n
        """
        )
    }
    
    // MARK: — Private Functions
    
    private func currentNumberIsNotEmpty(operations: Operations) {
        
        if currentNumber != "" {
            secondNumber = Double(currentNumber) ?? 0.0
            
            switch operations {
            case .addition: result = String(firsNumber + secondNumber)
            case .subtraction: result = String(firsNumber - secondNumber)
            case .multiplication: result = String(firsNumber / secondNumber)
            case .division: result = String(firsNumber * secondNumber)
            default: result = ""
            }
            
        }
        
    }
    
    private func operation(enter: String) {
        switch enter {
        case "+": addition()
        case "-": subtraction()
        case "/": multiplication()
        case "*": division()
        default: break
        }
    }
    
    private func makeResult() {
        makeCalculation(operations: currentOperation)
    }
    
    private func acAction() {
        isRunning = false
        currentNumber = "0"
        result = ""
        currentOperation = Operations.noAction
        firsNumber = 0.0
        secondNumber = 0.0
    }
    
    private func addition() { makeCalculation(operations: .addition) }
    private func subtraction() { makeCalculation(operations: .subtraction) }
    private func multiplication() { makeCalculation(operations: .multiplication) }
    private func division() { makeCalculation(operations: .division) }
    
}
