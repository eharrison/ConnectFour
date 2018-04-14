//
//  GameBoardCellView.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class GameBoardCellView: GameBoardStandardCellView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CFNotifications.gameBoardCellTouched.rawValue), object: position)
    }
    
}

// MARK: - View Initialization

extension GameBoardCellView {
    public static var newInstance: GameBoardCellView {
        return Bundle.main.loadNibNamed("GameBoardCellView", owner: self, options: nil)![0] as! GameBoardCellView
    }
}

// MARK: - GameBoard adding

extension GameBoardView {
    
    func addGameBoardCell(withPosition position: CFPosition, size: CFPosition) {
        let gameBoardCellView = GameBoardCellView.newInstance

        gameBoardCellView.configure(withPosition: position, size: frame.size.cellSize(withBoardSize: size))
        
        addSubview(gameBoardCellView)
    }
    
    func clearGameBoardCells() {
        for subview in subviews where subview is GameBoardCellView {
            subview.removeFromSuperview()
        }
    }
    
}
