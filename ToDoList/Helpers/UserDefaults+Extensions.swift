//
//  UserDefaults+Extensions.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import Foundation

fileprivate enum UserDefaultsKeys: String {
    case isFirstAppLaunch = "isFirstAppLaunch"
}

extension UserDefaults {
    func setIsFirstAppLaunchFlag(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isFirstAppLaunch.rawValue)
    }
    
    func getIsFirstAppLaunchFlag() -> Bool {
        return bool(forKey: UserDefaultsKeys.isFirstAppLaunch.rawValue)
    }
}
