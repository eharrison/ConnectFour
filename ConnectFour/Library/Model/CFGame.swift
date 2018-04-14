//
//  CFGame.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public struct CFGame: Codable {
    
    public let id: Int
    public let color1: String
    public let color2: String
    public let name1: String
    public let name2: String
    public let rows: Int
    public let column: Int
    
}

// MARK: - Json Decoding

extension CFGame {
    
    public static func parseGame(withData data: Data) -> [CFGame] {
        var colors: [CFGame] = []
        if let decoded = try? JSONDecoder().decode([CFGame].self, from: data) {
            colors = decoded
        }
        
        return colors
    }
    
}

