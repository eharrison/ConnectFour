//
//  GameBoardView.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

typealias WinCallback = () -> Void

public class GameBoardView: UIView {
    
    var winCallback: WinCallback?
    var gameManager: ConnectFourGameManager?
    
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
        gameManager = ConnectFourGameManager()
        gameManager?.configure(withGame: game)
        
        // refresh board
        refreshBoard()
    }
    
    fileprivate func refreshBoard() {
        clearGameBoardCells()
        
        guard let game = gameManager?.game else {
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
        
        gameManager?.handleTurn(withColumn: position.columns) { (position, size, isWinner) in
            // add checker
            self.addGameBoardChecker(withPosition: position, size: size) {
                if isWinner {
                    self.winCallback?()
                }
            }
        }
    }
}
