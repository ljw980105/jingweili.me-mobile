//
//  PersonalWebsiteAPI.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 9/21/20.
//

import Foundation
import Combine
import PersonalWebsiteModels
import Alamofire

enum PersonalWebsiteAPI {
    static let apiRoot = "https://jingweili.me/"
    
    
    static func loginWith(passcode: String) -> Future<Token, Error> {
        return ["password": passcode]
            .postToEndpoint("\(apiRoot)api/login", forResultTyped: Token.self)
    }
    
    static func logOut() -> Future<ServerResponse, Error> {
        SessionToken.delete()
        return GetRequest(endpoint: "\(apiRoot)api/logout")
            .needAuthentication()
            .get(resultType: ServerResponse.self)
    }
    
    static func getFiles(at directory: FileDirectory) -> Future<[FileToBrowse], Error> {
        return GetRequest(endpoint: "\(apiRoot)api/browse-files?directory=\(directory.rawValue)")
            .needAuthentication()
            .get(resultType: [FileToBrowse].self)
    }
}
