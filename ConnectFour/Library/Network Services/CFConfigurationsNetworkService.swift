//
//  CFConfigurationsNetworkService.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation
import AwesomeData

public class CFConfigurationsNetworkService {
    
    public var lastRequest: URLSessionDataTask?
    
    public func cancelLastRquest() {
        lastRequest?.cancel()
        lastRequest = nil
    }
    
    public func fetchConfigurations(_ response: @escaping ([CFConfigurations]) -> Void) {
        cancelLastRquest()
        
        lastRequest = AwesomeRequester.performRequest(configurationUrl, completion: { (data) in
            if let data = data {
                response(CFConfigurations.parseConfigurations(withData: data))
            } else {
                response([])
            }
        })
    }
    
}
