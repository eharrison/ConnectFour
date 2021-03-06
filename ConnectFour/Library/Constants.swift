//
//  Constants.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/14/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

public let mainUrl = "https://private-75c7a5-blinkist.apiary-mock.com/connectFour/"
public let configurationUrl = "\(mainUrl)configuration"
public let colorUrl = "\(mainUrl)configuration_color"
public let gameUrl = "\(mainUrl)configuration_game"
public let rulesUrl = "\(mainUrl)configuration_rules"

public let numberToWin = 4

enum CFNotifications: String {
    case gameBoardCellTouched
}

struct CFPosition {
    var rows: Int
    var columns: Int
}


