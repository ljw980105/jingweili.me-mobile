//
//  SessionToken.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 11/22/20.
//

import Foundation

enum SessionToken {
    private static let sessionKey = "session"
    
    static func set(token: String) {
        UserDefaults.standard.setValue(token, forKey: sessionKey)
    }
    
    static func get() -> String {
        return UserDefaults.standard.string(forKey: sessionKey) ?? ""
    }
    
    static func delete() {
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
}
