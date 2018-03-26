//
//  calculatorBrain.swift
//  wilson
//
//  Created by Macintosh on 2017/10/26.
//  Copyright © 2017年 www. All rights reserved.
//

import Foundation
func changSide(operand:Double)->Double{
    return -operand
}
func multiplication(op1:Double,op2:Double)->Double{
    return op1*op2
}
/*func plus(op1:Double,op2:Double)->Double{
    return op1+op2
}*/
 func clears(op1:Double,op2:Double)->Double{
        return op2
    }
struct calculatorBrain {
    private var accumulator :Double?
   
    private enum Operation{
        case clear((Double,Double)->Double)
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    private var operations : Dictionary<String,Operation>=[
        "π":Operation.constant(Double.pi),
        "e":Operation.constant(M_E),
        "√":Operation.unaryOperation(sqrt),
        "cos":Operation.unaryOperation(cos),
        //"±":Operation.unaryOperation(changSide),
        //"×":Operation.binaryOperation(multiplication),
        //"+":Operation.binaryOperation{(op1:Double,op2:Double)->Double in return op1+op2},
        "±":Operation.unaryOperation({-$0}),
        "+":Operation.binaryOperation({ $0 + $1 }),
        "-":Operation.binaryOperation({ $0 - $1 }),
        "×":Operation.binaryOperation({ $0 * $1 }),
        "÷":Operation.binaryOperation({ $0 / $1 }),
        "=":Operation.equals,
        "C":Operation.clear(clears)
    ]
    mutating func perfromOperationg(_ symbol:String)  {
        
        if let operation = operations[symbol]{
            
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if let operand = accumulator{
                    accumulator = function(operand)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = performBinaryOperation(function: function, firstOperad: accumulator!)
                    accumulator=nil
                }
            case .clear(let function):
                pendingBinaryOperation = performBinaryOperation(function: function, firstOperad: 0)
                accumulator = nil
            case .equals:
                perfomPendingBinaryOperad()
            }
        }
    }
    
    private mutating func perfomPendingBinaryOperad(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perfom(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    private var pendingBinaryOperation : performBinaryOperation?
    
    private struct performBinaryOperation{
        let function:(Double,Double)->Double
        let firstOperad:(Double)
        func perfom(with secondOperad:Double) -> Double {
            return function(firstOperad, secondOperad)
        }
    }
    
    mutating func setOperation(_ operand:Double){
        accumulator = operand
        
    }
    
    
    
    var returnValue:Double?{
        get{
            return accumulator
        }
    }
    
}
