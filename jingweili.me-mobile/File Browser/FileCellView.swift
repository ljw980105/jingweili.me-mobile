//
//  FileCellView.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/25/20.
//

import SwiftUI
import PersonalWebsiteModels

struct FileCellView: View {
    var file: FileToBrowse
    
    var body: some View {
        HStack {
            Image(file.imageName)
            VStack(alignment: .leading) {
                Text(file.name)
                    .font(.headline)
                Text("\(file.createdDateString) • \(file.fileSizeString)")
            }
        }
    }
}
