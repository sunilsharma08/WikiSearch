//
//  ErrorData.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation

struct ErrorData {
    
    var title:String?
    var description:String?
    
    init(title:String? = "ERROR".localized, message:String?) {
        self.title = title
        self.description = message
    }
}
