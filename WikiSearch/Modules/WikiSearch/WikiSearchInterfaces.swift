//
//  WikiSearchInterfaces.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol WSWireframeInterface: WireframeInterface {
    func showWikiPageFor(searchData: SearchData)
}

protocol WSViewInterface: ViewInterface {
    func reloadTableViewData()
    func setLoadingVisible(_ visible: Bool)
    func setEmptyDataMsgVisible(_ visible: Bool)
    func updateNavWith(title: String, backgroundColor: UIColor)
}

protocol WSPresenterInterface: PresenterInterface {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    
    func searchWiki(for query:String)
    
    func numberOfSectionsInTableView() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func data(forIndexPath indexPath: IndexPath) -> SearchData
    func didSelectItem(at indexPath: IndexPath)
    func shouldShowSectionHeader() -> Bool
    
    
}

protocol WSInteractorInterface: InteractorInterface {
    
    func searchWiki(for query:String, onCompletion:@escaping (_ status: RequestStatus, _ result: [SearchData]?, _ error: ErrorData?) -> Void)
    
    func getSearchHistoryFromCache(onCompletion: @escaping (_ status: RequestStatus, _ result: [SearchData]?, _ error: ErrorData?) -> Void)
}
