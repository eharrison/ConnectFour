//
//  CGSizeExtension.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//
import UIKit

extension CGSize {
    func cellSize(withBoardSize size: CFPosition) -> CGSize {
        return CGSize(width: width/CGFloat(size.columns), height: height/CGFloat(size.rows))
    }
}
