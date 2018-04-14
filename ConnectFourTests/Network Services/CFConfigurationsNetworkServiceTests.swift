//
//  CFConfigurationsNetworkServiceTests.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import ConnectFour

class CFConfigurationsNetworkServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_fetchConfigurations_ShouldStore_LastRequest() {
        
        CFConfigurationsNetworkService.shared.fetchConfigurations { (configurations) in
            
        }
        
        XCTAssertNotNil(CFConfigurationsNetworkService.shared.lastRequest, "last Collection request must not be nil")
    }

    func test_fetchConfigurations_When_CalledManyTimes_Should_Cancel_LastRequest() {
        let ex = expectation(description: "Should cancel last request")
        
        CFConfigurationsNetworkService.shared.fetchConfigurations { (configurations) in
            ex.fulfill()
        }
        CFConfigurationsNetworkService.shared.fetchConfigurations { (configurations) in
            
        }
        
        CFConfigurationsNetworkService.shared.cancelLastRquest()
        waitForExpectations(timeout: 5, handler: nil)
    }

}
