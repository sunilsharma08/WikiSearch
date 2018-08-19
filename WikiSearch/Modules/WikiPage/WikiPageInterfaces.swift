//
//  WikiPageInterfaces.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation

protocol WPWireframeInterface: WireframeInterface {
    
}

protocol WPViewInterface: ViewInterface {
    func loadWikiPageWith(url: URL)
    func updateViewTitle(string: String)
}

protocol WPPresenterInterface: PresenterInterface {
    func viewDidLoad()
    func failToLoadWikiPage(withError error: Error)
}

protocol WPInteractorInterface: InteractorInterface {
    func createWikiPageUrlString(withPageId pageId:Int) -> String
}
