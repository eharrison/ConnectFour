//
//  GameViewModel.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

class GameViewModel {
    
    var player: GameBoardPlayer = .player1
    
    func refreshGame(_ completion: @escaping (CFGame) -> Void) {
        CFGameNetworkService.shared.fetchGame { (games) in
            guard let game = games.first else {
                print("Couldn't fetch game...")
                return
            }
            
            completion(game)
        }
    }
    
}
