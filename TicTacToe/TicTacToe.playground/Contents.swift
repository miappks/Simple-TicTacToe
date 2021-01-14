//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Marcin Kessler on 14.01.21.
//  Copyright © 2021 Marcin Kessler. All rights reserved.
//


/*
 Functions for Tic-Tac-Toe Game
 */

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

/** Use the raw extension to specify Lednumber and not Arrayposition of Led
 Example: Position of first Item in Array == 0 || 1.raw
 */
extension Int {
    var raw :Int { return self - 1 }
}



/*
 TIC-TAC-TOE GAME
 Wired Buttons and Runtime functions | Specific Functions
 */

var activePlayer: Player = .circle
var isGameActive = true

var gameState = [
    0, 0, 0,
    0, 0, 0,
    0, 0, 0
]

//Button pressed on position -> position as ArrayPosition of gameState, use raw for LedPosition
func selectedPositionOnBoard(position:Int) {
    if !isGameActive { print("Game not Active"); return } //If gameState is false, cancel function
    if position > gameState.count - 1 || position < 0 { print("False position"); return }
    if gameState[position] != 0 { print("Position already used"); return }
    
    print("ActivePlayer:", activePlayer)
    
    gameState[position] = activePlayer.rawValue
    activePlayer = activePlayer.toggle()
    
    let determinedWinner = determineWinner(gameState: gameState)
    if determinedWinner != .none {
        print("Winner found:", determinedWinner) //Eventually show winner in Label
        isGameActive = false
    }
}

func resetGame() {
    for i in 0..<gameState.count {
        gameState[i] = Player.none.rawValue
    }
    isGameActive = true
    activePlayer = .circle
}

extension Int {
    var symbol :String {
        switch self {
        case Player.circle.rawValue:
            return "o"
        case Player.cross.rawValue:
            return "x"
        default:
            return " "
        }
    }
}

func printGameBoard(gameState:[Int]) {
    let printText = """

     \(gameState[0].symbol) | \(gameState[1].symbol) | \(gameState[2].symbol)
    –––––––––––
     \(gameState[3].symbol) | \(gameState[4].symbol) | \(gameState[5].symbol)
    –––––––––––
     \(gameState[6].symbol) | \(gameState[7].symbol) | \(gameState[8].symbol)

    """
    print(printText)
}



/*
 Play Tic-Tac-Toe Game
 */

resetGame()


selectedPositionOnBoard(position: 1.raw) //ActivePlayer: circle

selectedPositionOnBoard(position: 2.raw) //ActivePlayer: cross

selectedPositionOnBoard(position: 5.raw) //ActivePlayer: circle

selectedPositionOnBoard(position: 3.raw) //ActivePlayer: cross

selectedPositionOnBoard(position: 9.raw) //ActivePlayer: circle


printGameBoard(gameState: gameState)
