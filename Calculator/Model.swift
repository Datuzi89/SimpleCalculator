//
//  Model.swift
//  Calculator
//
//  Created by Xuezhu on 12/23/16.
//  Copyright © 2016 Xuezhu. All rights reserved.
//

import Foundation


class Model {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double)  {
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "±" : Operation.UnaryOperation({-$0}),
        "%" : Operation.UnaryOperation({$0 / 100}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "c" : Operation.Clear,
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
    }
    
    func performOperation(symbol: String)  {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let vaule):
                accumulator = vaule
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Clear:
                accumulator = 0
            case .Equals:
                exexecutePendingBinaryOperation()
            }
        }
    }
    
    private func exexecutePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
