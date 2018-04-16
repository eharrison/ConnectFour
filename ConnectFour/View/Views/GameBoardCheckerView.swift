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
        
        isHidden = true
        
        mainView.layer.cornerRadius = cellSize.width/2
    }
    
    func show(animated: Bool, completion: (() -> Void)? = nil) {
        isHidden = false
        
        if animated {
            let destinationFrame = frame
            frame.origin.y = -destinationFrame.size.height
            
            UIView.animate(withDuration: 0.5, animations: {
                self.frame = destinationFrame
            }) { (_) in
                completion?()
            }
        } else {
            completion?()
        }
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
    
    func addGameBoardChecker(withPosition position: CFPosition, size: CFPosition, animated: Bool = true, completion: (() -> Void)? = nil) {
        let gameBoardCheckerView = GameBoardCheckerView.newInstance
        
        gameBoardCheckerView.configure(withPosition: position, size: frame.size.cellSize(withBoardSize: size))
        gameBoardCheckerView.show(animated: animated, completion: completion)
        
        addSubview(gameBoardCheckerView)
    }
    
    func clearGameBoardCheckers() {
        for subview in subviews where subview is GameBoardCheckerView {
            subview.removeFromSuperview()
        }
    }
    
}

