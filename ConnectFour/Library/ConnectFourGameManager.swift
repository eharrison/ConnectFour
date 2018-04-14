//
//  ConnectFourGame.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

enum GameBoardCellStatus: Int {
    case empty
    case player1
    case player2
}

class ConnectFourGameManager: NSObject {
    
    public static var shared = ConnectFourGameManager()
    
    public var game: CFGame?
    public var player: GameBoardCellStatus = .player1
    public var cellStatusMatrix = [[GameBoardCellStatus]]()
    
    public func configure(withGame game: CFGame) {
        self.game = game
        
        // restart CellStatusMatrix
        cleanupMatrix()
    }
    
    func cleanupMatrix() {
        guard let game = game else {
            cellStatusMatrix = []
            return
        }
        
        cellStatusMatrix = Array(repeating: Array(repeating: .empty, count: game.rows), count: game.column)
    }
    
    func handleTurn(withColumn column: Int, completion: @escaping (_ position: CFPosition, _ size: CFPosition, _ won: Bool) -> Void) {
        guard let game = game else {
            return
        }
        
        var positionToAdd: CFPosition?
        var currentRow = game.rows-1
        
        // loops to matrix to see where we can add a checker
        while positionToAdd == nil, currentRow >= 0 {
            if cellStatusMatrix[column][currentRow] == .empty {
                positionToAdd = CFPosition(rows: currentRow, columns: column)
            }
            
            currentRow -= 1
        }
        
        guard let position = positionToAdd else {
            print("Column \(column) is full")
            return
        }
        
        // add the player checker to matrix
        cellStatusMatrix[position.columns][position.rows] = player
        
        completion(position, CFPosition(rows: game.rows, columns: game.column), checkWinner(withPosition: position))
    }
    
    public func checkWinner(withPosition position: CFPosition) -> Bool {
        if checkWinnerInColumn(withPosition: position) {
            return true
        }
        
        if checkWinnerInRow(withPosition: position) {
            return true
        }
    
        return false
    }
    
    // MARK: - ROW CHECK
    
    public func checkWinnerInRow(withPosition position: CFPosition) -> Bool {
        guard let game = game else {
            return false
        }
        
        // set range for searching winner
        let minColumn = position.columns - numberToWin >= 0 ? position.columns - numberToWin : 0
        let maxColumn = position.columns + numberToWin < game.column ? position.columns + numberToWin : game.column - 1
        
        var numberOfSequencials = 0
        
        // check for sequential occurences of checkers of current player
        for column in minColumn...maxColumn {
            if cellStatusMatrix[column][position.rows] == player {
                numberOfSequencials += 1
                
                // return true in case sequence is greater or equals to [numberToWin]
                if numberOfSequencials >= numberToWin {
                    return true
                }
            } else {
                numberOfSequencials = 0
            }
        }
        
        return false
    }
    
    // MARK: - COLUMN CHECK
    
    public func checkWinnerInColumn(withPosition position: CFPosition) -> Bool {
        guard let game = game else {
            return false
        }
        
        // if we don't at least have [numberToWin] occurences of current player, don't bother continuing in column check
        if cellStatusMatrix[position.columns].filter({ $0 == player }).count >= numberToWin {
            
            // check for sequential occurences of checkers of current player
            for row in position.rows..<game.rows {
                if cellStatusMatrix[position.columns][row] != player {
                    return false
                }
            }
            
            return true
        }
        
        return false
    }
    
}
