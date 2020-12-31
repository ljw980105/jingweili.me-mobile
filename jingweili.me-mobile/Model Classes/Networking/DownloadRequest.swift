//
//  DownloadRequest.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/30/20.
//

import Foundation
import Alamofire
import Combine

class DownloadRequest {
    private let endpoint: String
    private var authenticate = false
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    init(endpoint: URL) {
        self.endpoint = endpoint.relativeString
    }
    
    func needAuthentication() -> DownloadRequest {
        authenticate = true
        return self
    }
    
    /// Execute the download request. Note the returning URL is a temporary url store on device after the file has been downloaded
    func execute() -> Future<URL, Error> {
        return Future { promise in
            var headers: HTTPHeaders? = nil
            if self.authenticate {
                headers = HTTPHeaders([
                    HTTPHeader(name: "Authorization", value: "Bearer \(SessionToken.get())")
                ])
            }
            AF.download(self.endpoint, headers: headers).responseData { res in
                if let url = res.fileURL {
                    promise(.success(url))
                } else if let error = res.error {
                    print(error.localizedDescription)
                    promise(.failure(error))
                }
            }
        }
    }
    
}
