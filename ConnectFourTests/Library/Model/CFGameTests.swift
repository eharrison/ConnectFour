//
//  CFGameTests.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//


import XCTest
@testable import ConnectFour

class CFGameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ParseGameFromJSON_ShouldReturn_Array() {
        guard let data = MockJSONLoader.loadJSONData(file: "Game", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        let game = CFGame.parseGame(withData: data)
        
        XCTAssertEqual(game.count, 1)
    }
    
    func test_ParseGameFromJSON_ShouldReturn_CorrectData() {
        guard let data = MockJSONLoader.loadJSONData(file: "Game", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        let game = CFGame.parseGame(withData: data)
        
        XCTAssertEqual(game.first?.id, 1234567890)
        XCTAssertEqual(game.first?.color1, "#FF0000D9")
        XCTAssertEqual(game.first?.color2, "#0000FF26")
        XCTAssertEqual(game.first?.name1, "Sue")
        XCTAssertEqual(game.first?.name2, "Henry")
        XCTAssertEqual(game.first?.rows, 6)
        XCTAssertEqual(game.first?.column, 7)
    }
    
}
