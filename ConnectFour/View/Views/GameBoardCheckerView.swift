//
//  GameBoardCheckerView.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class GameBoardCheckerView: GameBoardStandardCellView {
    @IBOutlet weak var mainView: UIView!
    
    override func configure(withPosition position: CFPosition, size cellSize: CGSize) {
        super.configure(withPosition: position, size: cellSize)
        
        mainView.layer.cornerRadius = cellSize.width/2
    }
}

// MARK: - View Initialization

extension GameBoardCheckerView {
    public static var newInstance: GameBoardCheckerView {
        return Bundle.main.loadNibNamed("GameBoardCheckerView", owner: self, options: nil)![0] as! GameBoardCheckerView
    }
}

// MARK: - GameBoard adding

extension GameBoardView {
    
    func addGameBoardChecker(withPosition position: CFPosition, size: CFPosition) {
        let gameBoardCheckerView = GameBoardCheckerView.newInstance
        
        gameBoardCheckerView.configure(withPosition: position, size: frame.size.cellSize(withBoardSize: size))
        
        addSubview(gameBoardCheckerView)
    }
    
    func clearGameBoardCheckers() {
        for subview in subviews where subview is GameBoardCheckerView {
            subview.removeFromSuperview()
        }
    }
    
}

