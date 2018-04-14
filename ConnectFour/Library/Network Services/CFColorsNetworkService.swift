//
//  CFColorsNetworkService.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation
import AwesomeData

public class CFColorsNetworkService {
    
    public static var shared = CFColorsNetworkService()
    
    public var lastRequest: URLSessionDataTask?
    
    public func cancelLastRquest() {
        lastRequest?.cancel()
        lastRequest = nil
    }
    
    public func fetchColors(_ response: @escaping ([CFColors]) -> Void) {
        cancelLastRquest()
        
        lastRequest = AwesomeRequester.performRequest(colorUrl, completion: { (data) in
            if let data = data {
                response(CFColors.parseColors(withData: data))
            } else {
                response([])
            }
        })
    }
    
}
