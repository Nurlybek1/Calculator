//
//  CalcModel.swift
//  calculate
//
//  Created by Nurlybek Saktagan on 26.09.2021.
//

import Foundation

enum Operation {
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double,Double)->Double)
    case equals
}

struct CalculatorModel{
    var my_operation: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "+": Operation.binaryOperation({$0+$1}),
        "-": Operation.binaryOperation({$0-$1}),
        "x": Operation.binaryOperation({$0*$1}),
        "/": Operation.binaryOperation({$0/$1}),
        "+/-": Operation.unaryOperation({$0 * -1}),
        "%": Operation.unaryOperation({$0/100}),
        "C": Operation.constant(0),
        "=": Operation.equals,
        "cos": Operation.unaryOperation({cos($0)}),
        "tan": Operation.unaryOperation({tan($0)}),
        "sin": Operation.unaryOperation({sin($0)}),
        "x^2": Operation.unaryOperation({pow($0, 2)}),
        "x^3": Operation.unaryOperation({pow($0, 3)}),
        "x^y": Operation.binaryOperation({pow($0, $1)}),
    ]
    
    private var global_value: Double?
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    mutating func performOperation(_ operation: String){
        let symbol = my_operation[operation]! //!!!!!!!!!!!!!!!!!!
        switch symbol {
        case .constant(let value):
            global_value = value
        case .unaryOperation(let function):
            global_value = function(global_value!)
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
        case .equals:
            if global_value != nil{
                
        global_value = saving?.performOperationWith(secondOperand: global_value!)
            }
        }
    }
    func getResult() -> Double{
        return global_value!
    }
    var result: Double?{ // !!!!!!!!!!!!!!
        get{
            return global_value
        }
    }
    private var saving: SaveFirstOperandAndOperation?
    struct SaveFirstOperandAndOperation {
        var firstOperand: Double
        var operation: (Double,Double)->Double
        
        func performOperationWith(secondOperand op2:Double) -> Double {
            return operation(firstOperand,op2)
        }
    }
}
