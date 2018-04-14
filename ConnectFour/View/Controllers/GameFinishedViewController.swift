//
//  GameFinishedViewController.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class GameFinishedViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var gameFinishedViewModel = GameFinishedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
