//
//  DecimalUtils.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 05/02/23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
