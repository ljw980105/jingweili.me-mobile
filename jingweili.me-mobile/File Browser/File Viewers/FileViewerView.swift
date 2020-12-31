//
//  FileViewerView.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/30/20.
//

import SwiftUI
import PersonalWebsiteModels

struct FileViewerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = FileViewWrapperViewController
    let file: FileToBrowse
    let directory: FileDirectory
    let url: URL
    
    
    init(file: FileToBrowse, directory: FileDirectory) {
        self.file = file
        switch directory {
        case .public:
            url = PersonalWebsiteAPI.URLForPublicFile(named: file.name)
        case .private:
            url = PersonalWebsiteAPI.URLForPrivateFile(named: file.name)
        }
        self.directory = directory
    }
    
    func makeUIViewController(context: Context) -> FileViewWrapperViewController {
        return FileViewWrapperViewController(url: url, file: file)
    }
    
    func updateUIViewController(_ uiViewController: FileViewWrapperViewController, context: Context) {
        
    }
}
