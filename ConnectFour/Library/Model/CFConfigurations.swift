//
//  CFConfigurations.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public struct CFConfigurations: Codable {
    
    public let id: Int
    public let color1: String
    public let color2: String
    public let name1: String
    public let name2: String
    
}

// MARK: - Json Decoding

extension CFConfigurations {
    
    public static func parseConfigurations(withData data: Data) -> [CFConfigurations] {
        var configurations: [CFConfigurations] = []
        if let decoded = try? JSONDecoder().decode([CFConfigurations].self, from: data) {
            configurations = decoded
        }
        
        return configurations
    }
    
}
