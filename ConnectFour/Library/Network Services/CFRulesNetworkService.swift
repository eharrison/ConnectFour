//
//  CFRulesNetworkService.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation
import AwesomeData

public class CFRulesNetworkService {
    
    public static var shared = CFRulesNetworkService()
    
    public var lastRequest: URLSessionDataTask?
    
    public func cancelLastRquest() {
        lastRequest?.cancel()
        lastRequest = nil
    }
    
    public func fetchRules(_ response: @escaping ([CFRules]) -> Void) {
        cancelLastRquest()
        
        lastRequest = AwesomeRequester.performRequest(rulesUrl, completion: { (data) in
            if let data = data {
                response(CFRules.parseRules(withData: data))
            } else {
                response([])
            }
        })
    }
    
}
