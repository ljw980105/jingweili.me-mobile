//
//  FileViewWrapperViewController.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/30/20.
//

import UIKit
import PDFKit
import GSImageViewerController
import Combine
import PersonalWebsiteModels

class FileViewWrapperViewController: UIViewController {
    let url: URL
    var cancellables: [AnyCancellable] = []
    let file: FileToBrowse
    
    init(url: URL, file: FileToBrowse) {
        self.url = url
        self.file = file
        super.init(nibName: "FileViewWrapperViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = file.name
        async {
            DownloadRequest(endpoint: url)
                .needAuthentication()
                .execute()
        }
            .sink(receiveCompletion: { _ in }, receiveValue: { url in
                self.showImageIfValid(url: url)
                self.showPDFIfValid(url: url)
            })
            .store(in: &cancellables)
    }
    
    func showImageIfValid(url: URL) {
        guard file.fileType == .image else { return }
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            let imageInfo = GSImageInfo(image: image, imageMode: .aspectFill)
            let controller = GSImageViewerController(imageInfo: imageInfo)
            showViewWithConstraints(controller: controller)
        }
    }
    
    func showPDFIfValid(url: URL) {
        guard file.fileType == .pdf else { return }
        let pdfView = PDFView(frame: view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        showViewWithConstraints(view: pdfView)
    }
    
}
