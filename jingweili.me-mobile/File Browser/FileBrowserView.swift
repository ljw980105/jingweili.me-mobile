//
//  FileBrowserView.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 11/22/20.
//

import SwiftUI
import PersonalWebsiteModels

struct FileBrowserView: View {
    @State private var directory = 1
    @ObservedObject private var viewModel = FileBrowserViewModel()

    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.files, id: \.name) { file in
                    FileCellView(file: file)
                }
            }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker(
                            selection: $directory,
                            label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/,
                            content: {
                                Text("Public").tag(1)
                                Text("Private").tag(2)
                        })
                            .onChange(of: directory) { c in
                                self.viewModel.getFiles(at: FileDirectory(state: c))
                            }
                            .accentColor(.orange)
                    }
                }
                .navigationBarItems(leading: Button("Log Out") {
                    
                })
                .onAppear {
                    self.viewModel.getFiles(at: FileDirectory(state: directory))
                }
        }
    }
}

struct FileBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        FileBrowserView()
    }
}
