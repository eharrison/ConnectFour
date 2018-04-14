//
//  GameBoardView.swift
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

public class GameBoardView: UIView {
    
    private var game: CFGame?
    
    fileprivate var cellStatusMatrix = [[GameBoardCellStatus]]()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        
        // add observers to actions
        addObservers()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        refreshBoard()
    }
    
    public func configure(withGame game: CFGame) {
        self.game = game
        
        // restart CellStatusMatrix
        cellStatusMatrix = Array(repeating: Array(repeating: .empty, count: game.rows), count: game.column)
        
        // refresh board
        refreshBoard()
    }
    
    fileprivate func refreshBoard() {
        clearGameBoardCells()
        
        guard let game = game else {
            return
        }
        
        // add cells to board
        for row in 0..<game.rows {
            for column in 0..<game.column {
                addGameBoardCell(withPosition: CFPosition(rows: row, columns: column), size: CFPosition(rows: game.rows, columns: game.column))
            }
        }
    }
}

// MARK: - Observers

fileprivate extension Selector {
    static let cellTouched = #selector(GameBoardView.cellTouched(_:))
}

extension GameBoardView {
    
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self, selector: .cellTouched, name: NSNotification.Name(rawValue: CFNotifications.gameBoardCellTouched.rawValue), object: nil)
    }
    
    @objc fileprivate func cellTouched(_ sender: Any) {
        guard let notification = sender as? Notification, let position = notification.object as? CFPosition else {
            return
        }
        
        addChecker(toColumn: position.columns)
    }
    
    func addChecker(toColumn column: Int) {
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
        cellStatusMatrix[position.columns][position.rows] = .player1
        
        // add checker to view
        addGameBoardChecker(withPosition: position, size: CFPosition(rows: game.rows, columns: game.column))
    }
    
}
