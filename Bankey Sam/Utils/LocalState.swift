//
//  LocalState.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 01/02/23.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnboarding
    }
    
    public static var hasOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarding.rawValue)
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarding.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
