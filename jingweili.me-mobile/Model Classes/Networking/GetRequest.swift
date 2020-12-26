//
//  GetRequest.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 11/22/20.
//

import Foundation
import Alamofire
import Combine

class GetRequest {
    private let endpoint: String
    private var authenticate = false
    private var parameters: [String: Any]? = nil
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    // MARK: - Configuration
    
    func needAuthentication() -> GetRequest {
        authenticate = true
        return self
    }
    
    func addParameters(_ parameters: [String: Any]) -> GetRequest {
        self.parameters = !parameters.isEmpty ? parameters : nil
        return self
    }
    
    func addParameters(_ codable: Codable) -> GetRequest {
        let params = codable.asDictionary()
        return addParameters(params)
    }
    
    // MARK: - Request Methods
    func get<Result: Codable>(resultType: Result.Type) -> Future<Result, Error> {
        return Future { promise in
            var headers = [
                HTTPHeader(name: "Content-Type", value: "application/json")
            ]
            if self.authenticate {
                headers.append(HTTPHeader(name: "Authorization", value: "Bearer \(SessionToken.get())"))
            }
            AF.request(
                self.endpoint,
                method: .get,
                parameters: self.parameters,
                encoding: JSONEncoding.default,
                headers: HTTPHeaders(headers)).responseJSON
            { json in
                if let data = json.data {
                    do {
                        let resp = try GetRequest.decoder.decode(Result.self, from: data)
                        promise(.success(resp))
                    } catch let err {
                        print(err.localizedDescription)
                        promise(.failure(err))
                    }
                } else if let error = json.error {
                    print(error.localizedDescription)
                    promise(.failure(error))
                }
            }
        }
    }
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}

