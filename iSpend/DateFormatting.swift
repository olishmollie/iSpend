//
//  DateFormatting.swift
//  iSpend
//
//  Created by AJ Bond on 10/14/17.
//  Copyright © 2017 BondTwins. All rights reserved.
//

import Foundation

class DateFormatting {
    static let formatter = DateFormatter()
    static func set(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
    }
}
