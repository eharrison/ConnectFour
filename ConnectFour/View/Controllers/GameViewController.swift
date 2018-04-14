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
    }

}
