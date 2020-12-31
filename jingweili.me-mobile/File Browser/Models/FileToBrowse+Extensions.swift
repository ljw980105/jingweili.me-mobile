//
//  FileToBrowse+Extensions.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/25/20.
//

import Foundation
import PersonalWebsiteModels

extension FileToBrowse {
    enum GeneralFileType {
        case image
        case pdf
        case other
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static let byteFormatter: ByteCountFormatter = {
        let byteFormatter = ByteCountFormatter()
        byteFormatter.countStyle = .file
        return byteFormatter
    }()
    
    var imageName: String {
        switch fileType {
        case .image:
            return "imageIcon"
        case .pdf:
            return "pdfIcon"
        default:
            return "OtherFileIcon"
        }
    }
    
    var fileType: GeneralFileType {
        switch type {
        case "jpg", "png", "jpeg", "gif":
            return .image
        case "pdf":
            return .pdf
        default:
            return .other
        }
    }
    
    var createdDateString: String {
        FileToBrowse.dateFormatter.string(from: createdDate ?? Date())
    }
    
    var fileSizeString: String {
        FileToBrowse.byteFormatter.string(fromByteCount: fileSize ?? 0)
    }
}
 
