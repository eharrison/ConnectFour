//
//  CFConfigurationsTests.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import ConnectFour

class CFConfigurationsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ParseConfigurationsFromJSON_ShouldReturn_Array() {
        guard let data = MockJSONLoader.loadJSONData(file: "Configurations", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        let configurations = CFConfigurations.parseConfigurations(withData: data)
        
        XCTAssertEqual(configurations.count, 1)
    }
    
    func test_ParseConfigurationsFromJSON_ShouldReturn_CorrectData() {
        guard let data = MockJSONLoader.loadJSONData(file: "Configurations", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        let configurations = CFConfigurations.parseConfigurations(withData: data)
        
        XCTAssertEqual(configurations.first?.id, 1234567890)
        XCTAssertEqual(configurations.first?.color1, "#FF0000")
        XCTAssertEqual(configurations.first?.color2, "#0000FF")
        XCTAssertEqual(configurations.first?.name1, "Sue")
        XCTAssertEqual(configurations.first?.name2, "Henry")
    }
    
}
