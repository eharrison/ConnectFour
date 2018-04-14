//
//  ConnectFourGameManagerTests.swift
//  ConnectFourTests
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import ConnectFour

class ConnectFourGameManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ColumnSequence_IsWinner() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertTrue(connectFourGameManager.checkWinnerInColumn(withPosition: CFPosition(rows: 2, columns: 1)))
    }
    
    func test_ColumnSequence_IsNotWinner() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertTrue(!connectFourGameManager.checkWinnerInColumn(withPosition: CFPosition(rows: 2, columns: 2)))
        XCTAssertTrue(!connectFourGameManager.checkWinnerInColumn(withPosition: CFPosition(rows: 1, columns: 2)))
    }
    
    func test_RowSequence_IsWinner() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 0, columns: 3)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 0, columns: 4)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 0, columns: 5)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 0, columns: 6)))
        
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 2, columns: 1)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 2, columns: 2)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 2, columns: 3)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInRow(withPosition: CFPosition(rows: 2, columns: 4)))
    }
    
    fileprivate var cellStatusMatrixMock: [[GameBoardCellStatus]] {
       return [
            [.empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .player1, .player1, .player1, .player1],
            [.empty, .player1, .player1, .player2, .player1, .player1],
            [.player1, .empty, .player1, .empty, .empty, .empty],
            [.player1, .empty, .player1, .empty, .empty, .empty],
            [.player1, .empty, .empty, .empty, .empty, .empty],
            [.player1, .empty, .empty, .empty, .empty, .empty]
        ]
    }
    
    fileprivate var gameMock: CFGame {
        return CFGame(id: 11, color1: "", color2: "", name1: "", name2: "", rows: 6, column: 7)
    }
    
}

extension ConnectFourGameManagerTests {
    
    class ConnectFourGameManagerMock: ConnectFourGameManager {
        
        override init() {
            
        }
        
        var cellStatusMatrixMock: [[GameBoardCellStatus]] {
            return [
                [.empty, ]
            ]
        }
        
    }
    
}
