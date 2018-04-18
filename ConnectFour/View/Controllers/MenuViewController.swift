//
//  MenuViewController.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    
    var menuViewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player1Button.setTitle("loading_player".localized, for: .normal)
        player2Button.setTitle("loading_player".localized, for: .normal)
        
        // refresh game from API
        view.startLoadingAnimation()
        menuViewModel.refreshGame { (game) in
            self.view.stopLoadingAnimation()
            
            self.player1Button.setTitle("\("play_as".localized) \(game.name1)", for: .normal)
            self.player1Button.backgroundColor = game.color1.uiColor
            self.player2Button.setTitle("\("play_as".localized) \(game.name2)", for: .normal)
            self.player2Button.backgroundColor = game.color2.uiColor
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? GameViewController {
            viewController.gameViewModel.player = segue.identifier == "player1Segue" ? .player1 : .player2
        }
    }
    
    @IBAction func returnToMenu(_ sender: UIStoryboardSegue) {
        
    }
    
}
