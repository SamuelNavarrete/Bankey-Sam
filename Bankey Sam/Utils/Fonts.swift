//
//  Fonts.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 02/02/23.
//

import Foundation
import UIKit

enum Fonts: String {
    case SFProBook = "SFProText-Regular"
    case Tittle1 = "Title 1"
    case Tittle3 = "Title 3"
    case Subhead = "Subhead"

    func of(size: CGFloat) -> UIFont {
        let font = UIFont(name: rawValue, size: size - 1) ?? UIFont.systemFont(ofSize: size - 1)
        return font
    }
}

let passwordTextField : UIFont = {
    let passwordTextField = UIFont()
   
    return passwordTextField

}()





func GetType(size: CGFloat, TypeFont: String) -> UIFont {
    let font = UIFont(name: TypeFont, size: size - 1) ?? UIFont.systemFont(ofSize: size - 1)
    return font
}

//enum TypeFont: String {
//    case Font = ""
//
//
//    func GetType(size: CGFloat) -> UIFont {
//        let font = UIFont(name: rawValue, size: size - 1) ?? UIFont.systemFont(ofSize: size - 1)
//        return font
//    }
//}
