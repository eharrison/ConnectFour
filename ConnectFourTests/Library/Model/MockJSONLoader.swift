//
//  MockJSONLoader.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public struct MockJSONLoader {
    
    private init() {
        
    }
    
    static func loadJSONFrom(fileWithName: String, usingClass: NSObject) -> [String: AnyObject]? {
        let testBundle = Bundle(for: type(of: usingClass))
        if let path = testBundle.path(forResource: fileWithName, ofType: "json") {
            do {
                let jsonData = try? NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    return try! JSONSerialization.jsonObject(
                        with: jsonData! as Data,
                        options: JSONSerialization.ReadingOptions.mutableContainers
                        ) as! [String: AnyObject]
                }
            }
        }
        return nil
    }
    
    static func loadJSONData(file: String, usingClass: NSObject) -> Data? {
        let testBundle = Bundle(for: type(of: usingClass))
        if let path = testBundle.url(forResource: file, withExtension: "json") {
            do {
                return try? Data(contentsOf: path)
            }
        }
        return nil
    }
    
}
