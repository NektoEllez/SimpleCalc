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
    var firstNumber: Double = 0.0
    var secondNumber: Double = 0.0
    var displayView: ViewController
    
    init(displayView: ViewController) {
        self.displayView = displayView
    }
    
    // MARK: — Methods
    
    func numberAction(number: Int) {
        if currentNumber != "0" {
            currentNumber.append(String(number))
            displayView.updateDisplay(text: currentNumber)
        } else {
            currentNumber = String(number)
        }
    }
    func makeCalculation(operations: Operations) {
        if currentOperation != .noAction {
            currentNumberIsNotEmpty(operations: operations)
        } else {
            guard let currentNumberDouble = Double(currentNumber) else { return }
            firstNumber = currentNumberDouble
            currentNumber = ""
            displayView.updateDisplay(text: currentNumber)
            currentOperation = operations
        }
    }
    
    func makeResult() {
        makeCalculation(operations: currentOperation)
    }
    
    func acAction() {
        currentNumber = ""
        firstNumber = 0.0
        secondNumber = 0.0
        result = ""
        currentOperation = Operations.noAction
        displayView.updateDisplay(text: currentNumber)
    }
    
    func addition() { makeCalculation(operations: .addition) }
    func subtraction() { makeCalculation(operations: .subtraction) }
    func multiplication() { makeCalculation(operations: .multiplication) }
    func division() { makeCalculation(operations: .division) }
    
    func changeSign() {
        var temp = currentNumber
        if temp.contains("—") {
            let sign = ["—"]
            temp = String(temp.filter { !sign.contains(String($0)) })
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        } else {
            temp = "—" + currentNumber
            displayView.updateDisplay(text: currentNumber)
            currentNumber = temp
        }
    }
    
    func percent() {
        guard let doubleCurrentNumber = Double(currentNumber) else { return }
        currentNumber = String( doubleCurrentNumber / 100)
        displayView.updateDisplay(text: currentNumber)
        result = currentNumber
        guard let doubleResult = Double(result) else { return }
        firstNumber = doubleResult
    }
    
    func dot() {
        if currentNumber.contains(".") {
            return
        } else {
            currentNumber += "."
            displayView.updateDisplay(text: currentNumber)
        }
    }
    
    // MARK: — Private Functions
    
    private func currentNumberIsNotEmpty(operations: Operations) {
        
        if currentNumber != "" {
            secondNumber = Double(currentNumber) ?? 0.0
            
            switch operations {
            case .addition: result = String(firstNumber + secondNumber)
            case .subtraction: result = String(firstNumber - secondNumber)
            case .multiplication: result = String(firstNumber * secondNumber)
            case .division: result = String(firstNumber / secondNumber)
            default: result = ""
            }
            
            guard let resultInDouble = Double(result) else { return }
            firstNumber = resultInDouble
            if resultInDouble.truncatingRemainder(dividingBy: 1) == 0 {
                result = String(Int(resultInDouble))
            }
            currentNumber = result
            displayView.updateDisplay(text: currentNumber)
            currentOperation = .noAction
        }
        
    }
    
    private func operation(enter: String) {
        switch enter {
        case "+": addition()
        case "-": subtraction()
        case "*": multiplication()
        case "/": division()
        default: break
        }
    }
    
    
}
