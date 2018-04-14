//
//  GameBoardStandardCell.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class GameBoardStandardCellView: UIView {
    
    var position: CFPosition?
    
    func configure(withPosition position: CFPosition, size cellSize: CGSize) {
        self.position = position
        
        frame = CGRect(
            x: cellSize.width*CGFloat(position.columns),
            y: cellSize.height*CGFloat(position.rows),
            width: cellSize.width,
            height: cellSize.height)
    }
    
}
