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
    
    static func URLForPublicFile(named name: String) -> URL {
        let newName = name.replacingOccurrences(of: " ", with: "%20")
        return URL(string: "\(apiRoot)resources/\(newName)")!
    }
    
    static func URLForPrivateFile(named name: String) -> URL {
        let newName = name.replacingOccurrences(of: " ", with: "%20")
        return URL(string: "\(apiRoot)/api/stream-file?name=\(newName)&directory=private")!
    }
}
