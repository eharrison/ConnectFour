//
//  GameBoardView.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

public class GameBoardView: UIView {
    
    private var game: CFGame?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
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
        
        guard let game = game else {
            return
        }
        
        // add cells to board
        for row in 0..<game.rows {
            for column in 0..<game.column {
                addGameBoardCell(withPosition: (row, column), size: (game.rows, game.column))
            }
        }
    }
}
