//
//  StringExtensions.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/17/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
