//
//  Player.swift
//  TicTacToe
//
//  Created by Marcin Kessler on 14.01.21.
//

import Foundation


enum Player : Int{
    case none = 0, circle = 1, cross = 2
}

extension Player {
    func toggle() -> Player{
        var newValue = Player.circle
        
        if self == .circle {
            newValue = .cross
        }
        //else is cross or none, who's toogle to circle, that's defined by definition of newValue
        
        return newValue
    }
}


func determineWinner(gameState:[Int]) -> Player{
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    for combination in winningCombinations {
        
        if gameState[combination[0]] != Player.none.rawValue && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]] {

            return Player.init(rawValue: gameState[combination[0]]) ?? .none
        }
        
    }
    
    return .none
}
