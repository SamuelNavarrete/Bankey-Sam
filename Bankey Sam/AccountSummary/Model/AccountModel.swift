//
//  AccountModel.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 06/02/23.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
