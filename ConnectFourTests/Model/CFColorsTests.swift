//
//  CFColorsTests.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import ConnectFour

class CFColorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ParseColorsFromJSON_ShouldReturn_Array() {
        guard let data = MockJSONLoader.loadJSONData(file: "Colors", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        let colors = CFColors.parseColors(withData: data)
        
        XCTAssertEqual(colors.count, 1)
    }
    
    func test_ParseColorsFromJSON_ShouldReturn_CorrectData() {
        guard let data = MockJSONLoader.loadJSONData(file: "Colors", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        let colors = CFColors.parseColors(withData: data)
        
        XCTAssertEqual(colors.first?.id, 1234567890)
        XCTAssertEqual(colors.first?.color1, "#FF0000D9")
        XCTAssertEqual(colors.first?.color2, "#0000FF26")
        XCTAssertEqual(colors.first?.name1, "Sue")
        XCTAssertEqual(colors.first?.name2, "Henry")
    }
    
}
