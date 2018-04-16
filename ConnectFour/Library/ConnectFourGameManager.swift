//
//  ConnectFourGame.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

enum GameBoardCellStatus: Int {
    case empty
    case player1
    case player2
}

class ConnectFourGameManager: NSObject {
    
    public var game: CFGame?
    public var player: GameBoardCellStatus = .player1
    public var cellStatusMatrix = [[GameBoardCellStatus]]()
    
    public var colorForPlayer: UIColor? {
        switch player {
        case .player1:
            return game?.color1.uiColor
        case .player2:
            return game?.color2.uiColor
        default:
            return nil
        }
    }
    
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
        while currentRow >= 0 {
            if cellStatusMatrix[column][currentRow] == .empty {
                positionToAdd = CFPosition(rows: currentRow, columns: column)
                break
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
        
        if checkWinnerInDiagonal(withPosition: position) {
            return true
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
    
    // MARK: - ROW CHECK
    
    public func checkWinnerInRow(withPosition position: CFPosition) -> Bool {
        guard let game = game else {
            return false
        }
        
        // set range for searching winner
        let minColumn = minValue(position.columns)
        let maxColumn = maxValue(position.columns, withMax: game.column)
        
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
    
    // MARK: - DIAGONAL CHECK
    
    public func checkWinnerInDiagonal(withPosition position: CFPosition) -> Bool {
        guard let game = game else {
            return false
        }
        
        // set range for searching winner
        let minColumn = minValue(position.columns)
        let maxColumn = maxValue(position.columns, withMax: game.column)
        
        var numberOfSequencials = 0
        
        func checkDiagonal(rightToLeft: Bool) -> Bool {
            var row = position.rows - (rightToLeft ? (position.columns-minColumn) : (maxColumn-position.columns))
            if row < 0 {
                row = 0
            } else if row >= game.rows {
                row = game.rows - 1
            }
            
            var column = rightToLeft ? minColumn : maxColumn
            
            // check for sequential occurences of checkers of current player
            while (rightToLeft && column <= maxColumn) ||
                (!rightToLeft && column >= minColumn) {
                if cellStatusMatrix[column][row] == player {
                    numberOfSequencials += 1
                    
                    // return true in case sequence is greater or equals to [numberToWin]
                    if numberOfSequencials >= numberToWin {
                        return true
                    }
                } else {
                    numberOfSequencials = 0
                }
                
                row += 1
                if row >= game.rows {
                    row = game.rows - 1
                }
                
                column += rightToLeft ? 1 : -1
            }
            
            return false
        }
        
        // check from right to left
        if checkDiagonal(rightToLeft: true) {
            return true
        }
        
        // check from left to right
        if checkDiagonal(rightToLeft: false) {
            return true
        }
        
        return false
    }
    
    // Returns the mininum value based on number given, considering [numberToWin] and that it has to be greater than 0
    func minValue(_ number: Int) -> Int {
        let min = number - numberToWin + 1
        if min >= 0 {
            return min
        }
        
        return 0
    }
    
    // Returns the maximum value based on number given, considering [numberToWin] and that it has to be less than Max
    func maxValue(_ number: Int, withMax maxNumber: Int) -> Int {
        let max = number + numberToWin - 1
        if max < maxNumber {
            return max
        }
        
        return maxNumber-1
    }
    
}
