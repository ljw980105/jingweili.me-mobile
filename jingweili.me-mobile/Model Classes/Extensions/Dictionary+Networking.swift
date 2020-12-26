//
//  Dictionary+Networking.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 11/22/20.
//

import Foundation
import Alamofire
import Combine

extension Dictionary where Key == String {
    
    func postToEndpoint<Result: Codable>(
        _ endpoint: String,
        forResultTyped: Result.Type,
        authenticate: Bool = false) -> Future<Result, Error>
    {
        return Future { promise in
            var headers = [
                HTTPHeader(name: "Content-Type", value: "application/json")
            ]
            if authenticate {
                headers.append(HTTPHeader(name: "Authorization", value: "Bearer \(SessionToken.get())"))
            }
            AF.request(
                endpoint,
                method: .post,
                parameters: self,
                encoding: JSONEncoding.default,
                headers: HTTPHeaders(headers)).responseJSON
            { json in
                if let data = json.data {
                    do {
                        let resp = try JSONDecoder().decode(Result.self, from: data)
                        promise(.success(resp))
                    } catch let err {
                        promise(.failure(err))
                    }
                } else if let error = json.error {
                    promise(.failure(error))
                }
            }
        }
    }
    
}
