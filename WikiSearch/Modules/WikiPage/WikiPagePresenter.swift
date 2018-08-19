//
//  WikiPagePresenter.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation

class WikiPagePresenter {
    fileprivate weak var view: WPViewInterface?
    fileprivate var interactor: WPInteractorInterface
    fileprivate var wireframe: WPWireframeInterface
    var searchData:SearchData?
    
    init(wireframe: WPWireframeInterface, view: WPViewInterface, interactor: WPInteractorInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension WikiPagePresenter: WPPresenterInterface {
    
    func viewDidLoad() {
        
        if let pageId = searchData?.pageId,
            let title = searchData?.title {
            
            view?.updateViewTitle(string: title)
            
            if let url = URL(string: interactor.createWikiPageUrlString(withPageId: pageId)) {
                view?.loadWikiPageWith(url: url)
            } else {
                wireframe.showAlert(with: "ERROR".localized, message: "FAILED_TO_CREATE_URL".localized)
            }
        } else {
            wireframe.showAlert(with: "ERROR".localized, message: "CORRUPT_DATA".localized)
        }
    }
    
    func failToLoadWikiPage(withError error: Error) {
        wireframe.showAlert(with: "ERROR".localized, message: error.localizedDescription)
    }
    
}
