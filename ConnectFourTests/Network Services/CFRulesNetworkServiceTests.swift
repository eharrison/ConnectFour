//
//  CFRules.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import ConnectFour

class CFRulesNetworkServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_fetchRules_ShouldStore_LastRequest() {
        let rulesNetworkService = CFRulesNetworkService()
        
        rulesNetworkService.fetchRules { (rules) in
            
        }
        
        XCTAssertNotNil(rulesNetworkService.lastRequest, "last Collection request must not be nil")
    }
    
    func test_fetchRules_When_CalledManyTimes_Should_Cancel_LastRequest() {
        let ex = expectation(description: "Should cancel last request")
        
        let rulesNetworkService = CFRulesNetworkService()
        
        rulesNetworkService.fetchRules { (rules) in
            ex.fulfill()
        }
        rulesNetworkService.fetchRules { (rules) in
            
        }
        
        rulesNetworkService.cancelLastRquest()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}