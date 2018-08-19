//
//  SearchData.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation

struct SearchData {
    var pageId: Int
    var title: String
    var description: String?
    var thumbnailUrl: String?
    
    init(json: [String: Any]) {
        self.pageId = json[JSONKeys.pageId] as? Int ?? 0
        self.title = json[JSONKeys.title] as? String ?? ""
        if let terms = json[JSONKeys.terms] as? [String: Any],
            let descriptions = terms[JSONKeys.description] as? [String],
            descriptions.count > 0 {
            self.description = descriptions.first ?? ""
        }
        if let thumbnailInfo = json[JSONKeys.thumbnail] as? [String: Any],
            let thumbnailUrl = thumbnailInfo[JSONKeys.source] as? String {
            self.thumbnailUrl = thumbnailUrl
        }
    }
}
