//
//  WikiSearchWireframe.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit

class WikiSearchWireframe:BaseWireframe {
    
    private let storyboard = UIStoryboard(name: "WikiSearch", bundle: nil)
    
    init() {
        let viewController = storyboard.instantiateViewController(ofType: WikiSearchViewController.self)
        super.init(viewController: viewController)
        
        let interactor = WikiSearchInteractor()
        let presenter = WikiSearchPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
    }
    
}

extension WikiSearchWireframe: WSWireframeInterface {
    
    func showWikiPageFor(searchData: SearchData) {
        let wikiPageWireframe = WikiPageWireframe(searchData: searchData)
        navigationController?.pushWireFrame(wikiPageWireframe)
    }
}
