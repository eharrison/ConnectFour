//
//  CFColors.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public struct CFColors: Codable {
    
    public let id: Int
    public let color1: String
    public let color2: String
    public let name1: String
    public let name2: String
    
}

// MARK: - Json Decoding

extension CFColors {
    
    public static func parseColors(withData data: Data) -> [CFColors] {
        var colors: [CFColors] = []
        if let decoded = try? JSONDecoder().decode([CFColors].self, from: data) {
            colors = decoded
        }
        
        return colors
    }
    
}
