//: Playground - noun: a place where people can play

import UIKit


var a = [1,3,4,5,63,8,]

let c = a.count
func shuffleArray<T>(array:[T]) -> [T]{
    var n = array.count
    var finalArray = array
    while n >= 1{
        let g = Int(arc4random_uniform(UInt32(c)))
        let tempthing = finalArray[n-1]
        finalArray[n-1] = finalArray[g]
        finalArray[g] = tempthing
        n = n - 1
    }
    return finalArray
}
shuffleArray(array: a)
let x = CGfloat(11)
