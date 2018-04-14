//
//  GameBoardView.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

enum GameBoardCellStatus {
    case empty
    case player1
    case player2
}

public class GameBoardView: UIView {
    
    private var game: CFGame?
    
    fileprivate var cellStatusMatrix = [String: GameBoardCellStatus]()
    
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
        
        refreshBoard()
    }
    
    fileprivate func refreshBoard() {
        clearGameBoardCells()
        
        // initialise CellStatusMatrix
        cellStatusMatrix = [:]
        
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
        
        addElement(toColumn: position.columns)
        
        print("touched notification: \(position)")
    }
    
    func addElement(toColumn column: Int) {
        guard let game = game else {
            return
        }
        
        let position = CFPosition(rows: 0, columns: column)
        
        cellStatusMatrix[position.matrixPosition] = .player1
        
        addGameBoardChecker(withPosition: position, size: CFPosition(rows: game.rows, columns: game.column))
    }
    
}
