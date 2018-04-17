//
//  MenuViewModel.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public class MenuViewModel {
    
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
