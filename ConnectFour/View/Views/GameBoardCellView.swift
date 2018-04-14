//
//  GameBoardCellView.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class GameBoardCellView: UIView {
    
}

// MARK: - View Initialization

extension GameBoardCellView {
    public static var newInstance: GameBoardCellView {
        return Bundle.main.loadNibNamed("GameBoardCellView", owner: self, options: nil)![0] as! GameBoardCellView
    }
}

// MARK: - GameBoard adding

extension GameBoardView {
    
    func addGameBoardCell(withPosition position: (Int,Int), size: (Int, Int)) {
        let cellSize = CGSize(width: frame.size.width/CGFloat(size.0), height: frame.size.height/CGFloat(size.1))
        
        let gameBoardCellView = GameBoardCellView.newInstance
        gameBoardCellView.frame = CGRect(
            x: cellSize.width*CGFloat(position.0),
            y: cellSize.height*CGFloat(position.1),
            width: cellSize.width,
            height: cellSize.height)
        
        addSubview(gameBoardCellView)
    }
    
    func clearGameBoardCells() {
        for subview in subviews where subview is GameBoardCellView {
            subview.removeFromSuperview()
        }
    }
    
}
