//
//  AccountSummaryHeaderModel.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 06/02/23.
//

import Foundation

struct DataAccountHeader {
    let welcomeMessage: String
    let name: String
    let date: Date
    
    var dateFormatted: String {
        return date.monthDayYearString
    }

}
