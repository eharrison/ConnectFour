//
//  CFGameNetworkService.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation
import AwesomeData

public class CFGameNetworkService {
    
    public static var shared = CFGameNetworkService()
    
    public var lastRequest: URLSessionDataTask?
    
    public func cancelLastRquest() {
        lastRequest?.cancel()
        lastRequest = nil
    }
    
    public func fetchGame(_ response: @escaping ([CFGame]) -> Void) {
        cancelLastRquest()
        
        lastRequest = AwesomeRequester.performRequest(gameUrl, completion: { (data) in
            if let data = data {
                response(CFGame.parseGame(withData: data))
            } else {
                response([])
            }
        })
    }
    
}
