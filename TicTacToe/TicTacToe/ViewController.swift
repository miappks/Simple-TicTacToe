//
//  ViewController.swift
//  TicTacToe
//
//  Created by Marcin Kessler on 14.01.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activePlayerLabel: UILabel!
    @IBOutlet var keyButtons: Array<UIButton>!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var playerImageView: UIImageView!
    
    
    var activePlayer: Player = .circle
    var isGameActive = true

    var gameState = [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyButtons.forEach { (button) in
            button.setImage(UIImage(named: "Transparent"), for: .normal)
        }
        resetButton.isHidden = true
    }
    
    
    
    @IBAction func selectPositionOnBoard(_ sender: UIButton) {
        let position = sender.tag
        
        if !isGameActive { print("Game not Active"); return } //If gameState is false, cancel function
        if position > gameState.count - 1 || position < 0 { print("False position"); return }
        if gameState[position] != 0 { print("Position already used"); return }
        
        print("ActivePlayer:", activePlayer)
        
        sender.setImage(activePlayer == .cross ? UIImage(systemName: "xmark") : UIImage(systemName: "circle"), for: .normal)
        
        gameState[position] = activePlayer.rawValue
        activePlayer = activePlayer.toggle()
        
        let determinedWinner = determineWinner(gameState: gameState)
        if determinedWinner != .none {
            print("Winner found:", determinedWinner) //Eventually show winner in Label
            resetButton.isHidden = false
            playerImageView.image = determinedWinner == .cross ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
            activePlayerLabel.text = "Winner:"
            view.backgroundColor = .systemGreen
            isGameActive = false
            return
        }
        playerImageView.image = activePlayer == .cross ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
        
        if gameState.contains(0) == false {
            view.backgroundColor = .systemRed
            resetButton.isHidden = false
            playerImageView.image = nil
            activePlayerLabel.text = "No Winner"
        }
        
    }
    

    @IBAction func resetGame(_ sender: UIButton) {
        for i in 0..<gameState.count {
            gameState[i] = Player.none.rawValue
        }
        isGameActive = true
        activePlayer = .circle
        
        keyButtons.forEach { (button) in
            button.setImage(UIImage(named: "Transparent"), for: .normal)
        }
        resetButton.isHidden = true
        playerImageView.image = UIImage(systemName: "circle")
        activePlayerLabel.text = "Active Player:"
        view.backgroundColor = .systemBackground
    }


}

