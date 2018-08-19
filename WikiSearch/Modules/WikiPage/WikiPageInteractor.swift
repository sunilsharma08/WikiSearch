//
//  WikiPageInteractor.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation

class WikiPageInteractor {
    func createWikiPageUrlString(withPageId pageId:Int) -> String {
        return "http://en.wikipedia.org/?curid=\(pageId)"
    }
}

extension WikiPageInteractor: WPInteractorInterface {
    
}
