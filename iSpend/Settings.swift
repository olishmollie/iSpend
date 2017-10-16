//
//  Settings.swift
//  iSpend
//
//  Created by AJ Bond on 10/15/17.
//  Copyright © 2017 BondTwins. All rights reserved.
//

import Foundation

class Settings {
    static let sharedInstance = Settings()
    var spendingLimit: Double = 100
    
    func set(spendingLimit: Double) {
        self.spendingLimit = spendingLimit
    }
}
