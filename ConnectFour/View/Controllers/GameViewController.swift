//
//  GameViewController.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var gameBoardView: GameBoardView!
    
    var gameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.text = ""
        playerLabel.text = ""
        
        gameBoardView.shouldRefreshCallback = {
            self.statusLabel.text = self.gameBoardView.gameManager?.isMyTurn ?? false ? "status_turn_yours".localized : "status_turn_opponent".localized
        }
        gameBoardView.gameFinishedCallback = { (won) in
            self.performSegue(withIdentifier: "finishedSegue", sender: won)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // refresh game from API
        gameBoardView.startLoadingAnimation()
        gameViewModel.refreshGame { (game) in
            self.gameBoardView.stopLoadingAnimation()
            self.gameBoardView.configure(withGame: game, player: self.gameViewModel.player)
            self.playerLabel.text = self.gameViewModel.player == .player1 ? game.name1 : game.name2
            self.playerLabel.textColor = self.gameViewModel.player == .player1 ? game.color1.uiColor : game.color2.uiColor
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? GameFinishedViewController {
            viewController.gameFinishedViewModel.won = (sender as? Bool) ?? false
            viewController.gameFinishedViewModel.game = gameBoardView.gameManager?.game
        }
    }
}
