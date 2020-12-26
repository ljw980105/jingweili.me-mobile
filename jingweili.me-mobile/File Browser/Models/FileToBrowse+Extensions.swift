//
//  FileToBrowse+Extensions.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/25/20.
//

import Foundation
import PersonalWebsiteModels

extension FileToBrowse {
    var imageName: String {
        switch type {
        case "jpg", "png", "jpeg", "gif":
            return "imageIcon"
        case "pdf":
            return "pdfIcon"
        default:
            return "OtherFileIcon"
        }
    }
    
    var createdDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: createdDate ?? Date())
    }
    
    var fileSizeString: String {
        let byteFormatter = ByteCountFormatter()
        byteFormatter.countStyle = .file
        return byteFormatter.string(fromByteCount: fileSize ?? 0)
    }
}
