//
//  Constants.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

struct AppColors {
    static let primary = UIColor.white
    static let navText = UIColor(hexCode: "#263238")
    static let navBackground = UIColor.white
    
    static let navOfflineText = UIColor.darkGray
    static let navOfflineBackground = UIColor(hexCode: "#ECECEC")
}

struct RESTApi {
    
    static let baseUrl = "https://en.wikipedia.org/w/api.php"
    static let searchUrl = "\(baseUrl)?action=query&format=json&prop=pageimages|pageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=200&pilimit=15&wbptterms=description&gpslimit=15&gpssearch="
    
}

struct JSONKeys {
    
    static let query = "query"
    static let pages = "pages"
    static let pageId = "pageid"
    static let title = "title"
    static let thumbnail = "thumbnail"
    static let source = "source"
    static let terms = "terms"
    static let description = "description"
    
}

