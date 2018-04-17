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
    
    func test_DiagonalSequence_IsWinner() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 0, columns: 0)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 1, columns: 1)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 2, columns: 2)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 3, columns: 3)))
        
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 2, columns: 0)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 3, columns: 1)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 4, columns: 2)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 5, columns: 3)))
        
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 5, columns: 1)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 4, columns: 2)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 3, columns: 3)))
        XCTAssertTrue(connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 2, columns: 4)))
    }
    
    func test_DiagonalSequence_IsNotWinner() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertTrue(!connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 5, columns: 5)))
        XCTAssertTrue(!connectFourGameManager.checkWinnerInDiagonal(withPosition: CFPosition(rows: 4, columns: 4)))
    }
    
    func test_MinValue_IsCorrect() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertEqual(connectFourGameManager.minValue(0), 0)
        XCTAssertEqual(connectFourGameManager.minValue(1), 0)
        XCTAssertEqual(connectFourGameManager.minValue(2), 0)
        XCTAssertEqual(connectFourGameManager.minValue(3), 0)
        XCTAssertEqual(connectFourGameManager.minValue(4), 1)
        XCTAssertEqual(connectFourGameManager.minValue(5), 2)
    }
    
    func test_MaxValue_IsCorrect() {
        let connectFourGameManager = ConnectFourGameManager()
        connectFourGameManager.game = gameMock
        connectFourGameManager.player = .player1
        connectFourGameManager.cellStatusMatrix = cellStatusMatrixMock
        
        XCTAssertEqual(connectFourGameManager.maxValue(0, withMax: 7), 3)
        XCTAssertEqual(connectFourGameManager.maxValue(1, withMax: 7), 4)
        XCTAssertEqual(connectFourGameManager.maxValue(2, withMax: 7), 5)
        XCTAssertEqual(connectFourGameManager.maxValue(3, withMax: 7), 6)
        XCTAssertEqual(connectFourGameManager.maxValue(4, withMax: 7), 6)
    }
    
    fileprivate var cellStatusMatrixMock: [[GameBoardStatus]] {
       return [
            [.player1, .empty, .player1, .empty, .empty, .empty],
            [.empty, .player1, .player1, .player1, .player1, .player1],
            [.empty, .player1, .player1, .player2, .player1, .player1],
            [.player1, .empty, .player1, .player1, .empty, .player1],
            [.player1, .empty, .player1, .empty, .player2, .empty],
            [.player1, .empty, .empty, .empty, .empty, .player1],
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
        
        var cellStatusMatrixMock: [[GameBoardStatus]] {
            return [
                [.empty, ]
            ]
        }
        
    }
    
}
