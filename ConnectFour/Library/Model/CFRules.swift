//
//  CFRules.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public struct CFRules: Codable {
    
    // Bad String?
    
}

// MARK: - Json Decoding

extension CFRules {
    
    public static func parseRules(withData data: Data) -> [CFRules] {
        var colors: [CFRules] = []
        if let decoded = try? JSONDecoder().decode([CFRules].self, from: data) {
            colors = decoded
        }
        
        return colors
    }
    
}
