//
//  GameViewModel.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public class GameViewModel {
    
    public func refreshGame(_ completion: @escaping (CFGame) -> Void) {
        CFGameNetworkService.shared.fetchGame { (games) in
            guard let game = games.first else {
                print("Couldn't fetch game...")
                return
            }
            
            // get player status from firebase
            
            
            
            completion(game)
        }
    }
    
}
