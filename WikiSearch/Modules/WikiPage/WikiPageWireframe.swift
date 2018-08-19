//
//  WikiPageWireframe.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

class WikiPageWireframe: BaseWireframe {
    
    private let storyboard = UIStoryboard(name: "WikiPage", bundle: nil)
    
    init(searchData: SearchData) {
        let viewController = storyboard.instantiateViewController(ofType: WikiPageViewController.self)
        super.init(viewController: viewController)
        
        let interactor = WikiPageInteractor()
        let presenter = WikiPagePresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        presenter.searchData = searchData
    }
}

extension WikiPageWireframe: WPWireframeInterface {
    
}
