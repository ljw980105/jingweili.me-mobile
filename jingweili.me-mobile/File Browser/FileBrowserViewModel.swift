//
//  FileBrowserViewModel.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 11/22/20.
//

import Foundation
import SwiftUI
import Combine
import PersonalWebsiteModels

class FileBrowserViewModel: ObservableObject {
    @Published var files = [FileToBrowse]()
    var cancellables: Set<AnyCancellable> = Set()
    
    func getFiles(at directory: FileDirectory) {
        PersonalWebsiteAPI
            .getFiles(at: directory)
            .sink(receiveCompletion: { status in
                if case .failure(let error) = status {
                    print(error.localizedDescription)
                }
            }, receiveValue: { files in
                self.files = files
            })
            .store(in: &cancellables)
    }
}

enum FileDirectory: String {
    case `public`
    case `private`
    
    init(state: Int) {
        switch state {
        case 1:
            self = .public
        case 2:
            self = .private
        default:
            self = .public
        }
    }
}



