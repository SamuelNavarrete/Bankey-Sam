//
//  AccountSummaryModel.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 05/02/23.
//

import Foundation

struct AccountSumary {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
    
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(balance)
    }
}

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}
